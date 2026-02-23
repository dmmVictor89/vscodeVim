#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title openTerminal
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName dev

# Documentation:
# @raycast.author shackle89
# @raycast.authorURL https://raycast.com/shackle89

import subprocess
import time
import win32gui
import win32con
import pyautogui

def send_key(key):
    print("send_key is called")
    pyautogui.hotkey('alt', 'r')

    pyautogui.press('4')

    pyautogui.press('enter')



def find_wezterm_window():
    """wezterm 창을 찾는 함수"""
    def enum_windows(hwnd, windows):
        if win32gui.IsWindowVisible(hwnd):
            title = win32gui.GetWindowText(hwnd)
            if "zsh" in title.lower():
                windows.append(hwnd)
    windows = []
    win32gui.EnumWindows(enum_windows, windows)
    return windows[0] if windows else None

def main():
    # 1. wezterm 실행
    subprocess.Popen(["wezterm"])

    # 2. wezterm 창 찾기 (잠시 대기 후)
    time.sleep(2)
    hwnd = find_wezterm_window()

    print("waiting end")
    if hwnd:
        # 3. wezterm 창 최대화
        win32gui.ShowWindow(hwnd, win32con.SW_MAXIMIZE)
    else:
        print("wezterm window not found")
    
    # 4. 키 전송
    print("waiting end")
    time.sleep(1)
    send_key(None)



if __name__ == "__main__":
    main()
