import json
import os
import subprocess
import sys
import getpass
import time
import tempfile
from pathlib import Path
from urllib.parse import urlparse


# =========================
# 사용자 설정
# =========================
KEEPASSXC_CLI = r"C:\Program Files\KeePassXC\keepassxc-cli.exe"
KEEPASSXC_DB = r"C:\Users\jinpyo\AppData\Local\nvim\util\browser\pwd.kdbx"

# 필요하면 여기에 키 파일 경로 추가
KEEPASSXC_KEYFILE = None
# 예:
# KEEPASSXC_KEYFILE = r"C:\Users\YOUR_NAME\Documents\passwords.keyx"

# 엔트리 검색 시 우선적으로 볼 그룹 경로가 있으면 지정 가능
# 예: "Internet"
KEEPASSXC_GROUP = None

# CLI timeout
CMD_TIMEOUT = 20
MASTER_PASSWORD = None
CACHE_TTL_SECONDS = 9 * 60 * 60
PASSWORD_CACHE_PATH = os.path.join(tempfile.gettempdir(), "qute_keepassxc_master_cache.json")


def die(msg: str) -> None:
    qute_message(f"keepassxc script error: {msg}", level="error")
    sys.exit(1)


def qute_message(msg: str, level: str = "info") -> None:
    """
    qutebrowser에 메시지 출력
    level: info / warning / error
    """
    safe = json.dumps(msg)
    cmd = f"message-{level} {safe}"
    send_qute_command(cmd)


def send_qute_command(cmd: str) -> None:
    fifo = os.environ.get("QUTE_FIFO")
    if not fifo:
        print("QUTE_FIFO not found. This script must run from qutebrowser.", file=sys.stderr)
        sys.exit(1)

    with open(fifo, "a", encoding="utf-8") as f:
        f.write(cmd + "\n")


def enter_passthrough_mode() -> None:
    send_qute_command("mode-enter passthrough")


def leave_current_mode() -> None:
    send_qute_command("mode-leave")


def load_cached_master_password() -> str:
    try:
        with open(PASSWORD_CACHE_PATH, "r", encoding="utf-8") as cache_file:
            payload = json.load(cache_file)
    except (FileNotFoundError, ValueError, OSError):
        return ""

    expires_at = int(payload.get("expires_at", 0))
    if expires_at <= int(time.time()):
        return ""
    return str(payload.get("password", ""))


def save_cached_master_password(password: str) -> None:
    if not password:
        return
    payload = {
        "password": password,
        "expires_at": int(time.time()) + CACHE_TTL_SECONDS,
    }
    try:
        with open(PASSWORD_CACHE_PATH, "w", encoding="utf-8") as cache_file:
            json.dump(payload, cache_file)
    except OSError:
        pass


def get_master_password(force_prompt: bool = False) -> str:
    global MASTER_PASSWORD
    if MASTER_PASSWORD and not force_prompt:
        return MASTER_PASSWORD
    if not force_prompt:
        cached = load_cached_master_password()
        if cached:
            MASTER_PASSWORD = cached
            return MASTER_PASSWORD

    if os.name == "nt":
        enter_passthrough_mode()
        try:
            import tkinter as tk
            from tkinter import simpledialog
            root = tk.Tk()
            root.withdraw()
            root.attributes("-topmost", True)
            password = simpledialog.askstring(
                "KeePassXC",
                "데이터베이스 마스터 비밀번호를 입력하세요",
                show="*",
                parent=root,
            )
            root.destroy()
        except Exception:
            password = getpass.getpass("KeePassXC master password: ")
        finally:
            leave_current_mode()
    else:
        password = getpass.getpass("KeePassXC master password: ")

    if not password:
        die("Master password input cancelled")

    MASTER_PASSWORD = password
    save_cached_master_password(MASTER_PASSWORD)
    return MASTER_PASSWORD


def is_auth_error(detail: str) -> bool:
    lowered = detail.lower()
    keywords = (
        "hmac",
        "invalid credentials",
        "wrong key",
        "자격 증명",
        "잠금 해제",
    )
    return any(keyword in lowered for keyword in keywords)


def run_cli(args, input_text=None, retry_on_auth_error=True, allow_failure=False) -> str:
    if not Path(KEEPASSXC_CLI).exists():
        die(f"keepassxc-cli.exe not found: {KEEPASSXC_CLI}")

    if not Path(KEEPASSXC_DB).exists():
        die(f"database not found: {KEEPASSXC_DB}")

    cmd = [KEEPASSXC_CLI] + args
    if KEEPASSXC_KEYFILE and args:
        cmd = [KEEPASSXC_CLI, args[0], "--key-file", KEEPASSXC_KEYFILE] + args[1:]

    password = get_master_password()
    stdin_payload = f"{password}\n"
    if input_text:
        stdin_payload += input_text

    try:
        proc = subprocess.run(
            cmd,
            input=stdin_payload,
            text=True,
            capture_output=True,
            timeout=CMD_TIMEOUT,
            encoding="utf-8",
            errors="replace",
        )
    except subprocess.TimeoutExpired:
        die("keepassxc-cli timed out")

    if proc.returncode != 0:
        stderr = (proc.stderr or "").strip()
        stdout = (proc.stdout or "").strip()
        detail = stderr or stdout or f"exit code {proc.returncode}"
        if retry_on_auth_error and is_auth_error(detail):
            get_master_password(force_prompt=True)
            return run_cli(
                args,
                input_text=input_text,
                retry_on_auth_error=False,
                allow_failure=allow_failure,
            )
        if allow_failure:
            return ""
        die(detail)

    return proc.stdout


def get_current_url() -> str:
    url = os.environ.get("QUTE_URL", "").strip()
    if not url:
        die("QUTE_URL is empty")
    return url


def normalize_host(host: str) -> str:
    host = host.lower().strip()
    if host.startswith("www."):
        host = host[4:]
    return host


def host_candidates(host: str):
    """
    host가 sub.example.com 이면
    우선순위:
    - sub.example.com
    - example.com
    """
    parts = host.split(".")
    candidates = []
    for i in range(len(parts) - 1):
        cand = ".".join(parts[i:])
        if "." in cand:
            candidates.append(cand)
    # 중복 제거
    seen = set()
    result = []
    for x in candidates:
        if x not in seen:
            seen.add(x)
            result.append(x)
    return result


def list_entries() -> list[str]:
    args = ["ls", KEEPASSXC_DB]
    if KEEPASSXC_GROUP:
        args.append(KEEPASSXC_GROUP)

    out = run_cli(args)
    lines = [line.strip() for line in out.splitlines() if line.strip()]
    # 그룹 경로처럼 끝에 / 붙은 것은 제외
    return [x for x in lines if not x.endswith("/")]


def choose_entry(entries: list[str], host: str) -> str | None:
    """
    가장 단순하고 안정적인 방식:
    1. 정확히 host와 같은 엔트리명
    2. path 마지막 이름이 host와 같은 경우
    3. host 포함 엔트리
    4. 상위 도메인 포함 엔트리
    """
    candidates = host_candidates(host)
    candidate_set = set(candidates)

    # 0) URL 속성 기반 매칭 (엔트리명이 도메인이 아니어도 매칭 가능)
    for entry in entries:
        for attr in ("URL", "Url", "url", "KP2A_URL"):
            raw = get_attribute(entry, attr, allow_failure=True)
            if not raw:
                continue
            for token in [x.strip() for x in raw.splitlines() if x.strip()]:
                parsed = urlparse(token if "://" in token else f"https://{token}")
                url_host = normalize_host(parsed.hostname or "")
                if not url_host:
                    continue
                if url_host in candidate_set or any(
                    url_host.endswith(f".{cand}") for cand in candidate_set
                ):
                    return entry

    norm_entries = [(e, e.lower()) for e in entries]

    # 1) 정확히 동일
    for cand in candidates:
        for original, lower in norm_entries:
            if lower == cand:
                return original

    # 2) 마지막 path segment 동일
    for cand in candidates:
        for original, lower in norm_entries:
            last = lower.split("/")[-1]
            if last == cand:
                return original

    # 3) 포함 검색
    for cand in candidates:
        for original, lower in norm_entries:
            if cand in lower:
                return original

    return None


def get_attribute(entry: str, attr: str, allow_failure: bool = False) -> str:
    args = ["show", KEEPASSXC_DB, entry, "--attributes", attr]
    out = run_cli(args, allow_failure=allow_failure)
    return out.strip()


def fake_key_raw(text: str) -> None:
    for character in text:
        sequence = '" "' if character == " " else r"\{}".format(character)
        send_qute_command(f"fake-key {sequence}")


def fill_login_form(username: str, password: str) -> None:
    js = """
(() => {
  function visible(el) {
    if (!el) return false;
    const style = window.getComputedStyle(el);
    const rect = el.getBoundingClientRect();
    return style.display !== 'none' &&
           style.visibility !== 'hidden' &&
           !el.disabled &&
           rect.width > 0 &&
           rect.height > 0;
  }

  const pwFields = Array.from(document.querySelectorAll('input[type="password"]'))
    .filter(visible);

  if (pwFields.length === 0) {
    return "password field not found";
  }

  const pw = pwFields[0];
  let user = null;

  if (pw.form) {
    const formCandidates = Array.from(
      pw.form.querySelectorAll('input[type="text"], input[type="email"], input[name*="user" i], input[name*="login" i], input[name*="id" i], input[name*="email" i]')
    ).filter(visible);
    if (formCandidates.length > 0) {
      user = formCandidates[0];
    }
  }

  if (!user) {
    const allCandidates = Array.from(
      document.querySelectorAll('input[type="text"], input[type="email"], input[name*="user" i], input[name*="login" i], input[name*="id" i], input[name*="email" i]')
    ).filter(visible);
    if (allCandidates.length > 0) {
      user = allCandidates[0];
    }
  }

  if (user) {
    user.focus();
    if (typeof user.select === 'function') {
      user.select();
    }
    return "focused-user";
  }

  pw.focus();
  if (typeof pw.select === 'function') {
    pw.select();
  }
  return "focused-password";
})()
""".strip().replace("\n", " ")

    send_qute_command(f"jseval --quiet {json.dumps(js)}")
    if username:
        fake_key_raw(username)
        send_qute_command("fake-key <Tab>")
    fake_key_raw(password)
    send_qute_command("mode-enter insert")


def main():
    url = get_current_url()
    parsed = urlparse(url)
    host = normalize_host(parsed.hostname or "")
    if not host:
        die("cannot parse host from URL")

    entries = list_entries()
    if not entries:
        die("No entries found in KeePassXC database")

    entry = choose_entry(entries, host)
    if not entry:
        die(f"No matching entry for host: {host}")

    username = ""
    password = ""

    # KeePassXC attribute naming can vary by CLI/database version.
    for attr in ("UserName", "Username", "user", "username"):
        username = get_attribute(entry, attr)
        if username:
            break

    for attr in ("Password", "password"):
        password = get_attribute(entry, attr)
        if password:
            break

    if not password:
        die(f"Password is empty for entry: {entry}")

    fill_login_form(username, password)
    qute_message(f"KeePassXC filled credentials for {host}", level="info")


if __name__ == "__main__":
    main()