
local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.log_info("🔥 WezTerm 시작 테스트")

-- 환경구분을 위해서 hostname 호출
-- home: DESKTOP-LEKLO7C
local hostname = wezterm.hostname()

local userName = os.getenv("USERNAME");

local prog = ""
-- wezterm.lua의 상단에 추가
if hostname == "DESKTOP-LEKLO7C" then
  package.path = package.path .. ";C:/Users/trueticket89/AppData/Local/nvim/wezterm/?.lua"
  prog = "D:\\My Program Files\\Git\\bin\\bash.exe"
else
  package.path = package.path .. ";C:/Users/이진표/AppData/Local/nvim/wezterm/?.lua"
  prog = "C:\\My Program Files\\Git\\bin\\bash.exe"
end

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)


-- 설정 -----------------------------
local config = wezterm.config_builder()


config.enable_csi_u_key_encoding = true

config.default_prog = { prog, "-l" }
config.font_size = 12.0
config.font = wezterm.font_with_fallback({
  "D2Coding",
  "JetBrains Mono",
  "Noto Sans",
})
config.color_scheme = 'Catppuccin Mocha'

config.leader = { mods = "CTRL", key = " ", timeout_milliseconds = 2000, }

local panel = require("wezterm_panel")
require("plugin")
config.launch_menu = panel.launch_menu
panel.show_launcher_on_startup()

local general_keys = {
  
    { key = "Enter", mods = "ALT|SHIFT", action = act.SplitVertical{domain="CurrentPaneDomain"} },
    { key = "Enter", mods = "CTRL|SHIFT", action = act.SplitHorizontal{domain="CurrentPaneDomain"} },
    { key = "x", mods = "ALT", action = act.CloseCurrentPane { confirm = true } },
    { key = "j", mods = "ALT", action = act.ActivatePaneDirection("Left") },
    { key = "k", mods = "ALT", action = act.ActivatePaneDirection("Down") },
    { key = "l", mods = "ALT", action = act.ActivatePaneDirection("Up") },
    { key = ";", mods = "ALT", action = act.ActivatePaneDirection("Right") },

    -- pane 크기 조절 (Alt + 방향키)
    { key = "LeftArrow",  mods = "ALT", action = act.AdjustPaneSize({ "Left", 10 }) },
    { key = "RightArrow", mods = "ALT", action = act.AdjustPaneSize({ "Right", 10 }) },
    { key = "UpArrow",    mods = "ALT", action = act.AdjustPaneSize({ "Up", 10 }) },
    { key = "DownArrow",  mods = "ALT", action = act.AdjustPaneSize({ "Down", 10 }) },

    -- { key = "x", mods = "ALT|SHIFT", action = act.ActivateCopyMode},
    { key = "c", mods = "LEADER", action = act.ActivateCopyMode},
    { key = 'v', mods = "LEADER", action = act.PasteFrom 'Clipboard' },
    -- { key = 'v', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' } }, -- 선택 모드
    
    -- 단축키로 메뉴 띄우기 (예: Ctrl+Shift+L)
    { key = "l", mods = "CTRL|SHIFT",
      action = wezterm.action.InputSelector {
        title = "SSH 연결 선택",
        choices = panel.selector_choices,
        action = wezterm.action_callback(function(window, pane, selected_id)
          if selected_id and type(selected_id) == "string" and selected_id ~= "" then
            local command_args = panel.commands_by_id[selected_id]
      
            if command_args then
              local command_string = table.concat(command_args, " ")
      
              -- 액션 목록을 wezterm.action.Multiple로 감싸줍니다.
              window:perform_action(
                wezterm.action.Multiple {
                  -- 실행할 액션들을 테이블 안에 순서대로 나열
                  wezterm.action.SendString(command_string),
                  wezterm.action.SendKey{key="Enter"}
                },
                pane -- 액션을 실행할 대상 Pane
              )
      
            else
              -- wezterm.log_error("Command args not found for ID: " .. selected_id)
            end
          else
            -- ... (취소 또는 에러 로그)
          end
        end),
      }
    },
-- 새탭에서    
--[[     { key = "l", mods = "CTRL|SHIFT"
    -- , action = wezterm.action.ShowLauncher,
    , action = wezterm.action.InputSelector {
      title = "SSH 연결 선택",
      choices = panel.selector_choices,
      -- 콜백 함수의 세 번째 인자를 'choice' 대신 'selected_id'로 명명 (가독성)
      action = wezterm.action_callback(function(window, pane, selected_id)
        wezterm.log_info("InputSelector callback started.")
    
        -- selected_id가 nil이 아니고 비어있지 않은 문자열인지 확인
        if selected_id and type(selected_id) == "string" and selected_id ~= "" then
          -- 이제 selected_id는 "ssh_snlnas" 같은 문자열 ID 자체임
          wezterm.log_info("Selected choice ID: " .. selected_id)
    
          -- selected_id를 직접 사용하여 명령어 조회
          local command_args = panel.commands_by_id[selected_id]
    
          if command_args then
            wezterm.log_info("Found command_args (JSON): " .. wezterm.json_encode(command_args))
            wezterm.log_info("Attempting to perform action SpawnCommandInNewTab...")
    
            window:perform_action(
              wezterm.action.SpawnCommandInNewTab {
                args = command_args
              },
              pane
            )
            wezterm.log_info("SpawnCommandInNewTab action performed.")
          else
            -- 매핑 테이블에 ID가 없는 경우
            wezterm.log_error("Command args not found for ID: " .. selected_id)
          end
        else
          -- 선택이 취소되었거나 예상치 못한 타입인 경우
          if selected_id == nil then
            wezterm.log_info("InputSelector choice was cancelled (nil).")
          else
            -- nil도 아니고 문자열도 아닌 경우 (예상치 못한 상황)
            wezterm.log_error("InputSelector returned unexpected data: " .. wezterm.json_encode(selected_id))
          end
        end
      end),

    },
  }, ]]

    -- 검색
    { key = "/", mods = "CTRL|ALT", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },

    
  -- CTRL-SHIFT-l activates the debug overlay
  { key = 'L', mods = 'CTRL|ALT', action = wezterm.action.ShowDebugOverlay },

    -- 로그
    {
      key = 'k',
      mods = 'CTRL|ALT',
      action = wezterm.action.EmitEvent 'start-logging'
    },

    {
      key = "r",
      mods = "CTRL|ALT",
      action = wezterm.action.Multiple {
      
        
        -- 1. 먼저 clear 및 마커 찍기
        wezterm.action.EmitEvent "clear-and-mark",

        -- 2. 200ms 기다렸다가 로그 저장
        wezterm.action_callback(function(window, pane)
          wezterm.sleep_ms(200) -- 마커가 출력될 시간 확보
          window:perform_action(
            wezterm.action.EmitEvent "save-log-after-marker",
            pane
          )
        end),


      },
    }
    

}

-- 로그 파일 경로 생성
local function get_log_path()
  -- return "C:\\Users\\이진표\\logs\\wezterm_log_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
  -- return "C:\\Users\\이진표\\logs\\wezterm_log.txt"
  return "C:\\Users\\" .. userName .. "\\logs\\wezterm_log.txt"
end

-- 사용자 정의 이벤트로 로그 기록 시작
wezterm.on('start-logging', function(window, pane)
  local log_path = get_log_path()
  wezterm.log_info("Saving log to: " .. log_path)
  -- local text = pane:get_lines_as_text(10000) -- 현재 화면의 최대 1000줄
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
  local f = io.open(log_path, "w+") -- "w"로 새 파일 생성
  if f then
      f:write(text)
      f:close()
  else
      wezterm.log_error("Failed to open log file: " .. log_path)
  end
end)

-- 1. clear + marker 출력
wezterm.on("clear-and-mark", function(window, pane)
  pane:send_text("clear\n")
  wezterm.sleep_ms(50)
  pane:send_text("echo CLEAR_MARKER_123456\n")

  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  pane:send_text("echo " .. timestamp .. "\n")
end)

-- 2. 로그 저장 (마커 이후만)
wezterm.on("save-log-after-marker", function(window, pane)
  local log_path = get_log_path()
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
  local marker = "CLEAR_MARKER_123456"

  -- 모든 마커 위치 추출
  local positions = {}
  for pos in text:gmatch("()" .. marker) do
    table.insert(positions, pos)
  end

  local filtered = "-- Marker not found --"

  if #positions >= 2 then
    -- 마지막 두 개의 마커 사이만 추출
    local start_pos = positions[#positions - 1]
    local end_pos = positions[#positions]

    -- 마커 라인 이후부터 다음 마커 직전까지 추출
    local from = text:find("\n", start_pos) or start_pos
    local to = end_pos - 1
    filtered = text:sub(from + 1, to - 1):gsub("^%s*\n?", "")
  else
    filtered = "-- Not enough markers found --"
  end

  -- 저장
  local f = io.open(log_path, "w")
  if f then
    f:write(filtered)
    f:close()
    window:toast_notification("WezTerm", "✅ Log saved between last two markers", nil, 500)
  else
    window:toast_notification("WezTerm", "❌ Failed to save log file", nil, 500)
  end
end)


config.key_tables = {
    copy_mode = {
      -- 방향키 변경: jkl;로 매핑
      { key = "j", action = act.CopyMode("MoveLeft") },
      { key = "k", action = act.CopyMode("MoveDown") },
      { key = "l", action = act.CopyMode("MoveUp") },
      { key = ";", action = act.CopyMode("MoveRight") },

      -- 선택 모드 진입
      { key = "v", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
      -- 단순 복사
      { key = 'y',
        mods = 'NONE',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
        },
      },
      -- 복사 후 선택모드 종료
      { key = 'u', mods = 'NONE', action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'MoveToScrollbackBottom' },
          { CopyMode = 'Close' },
        },
      },
      -- 종료
      { key = "q", action = act.CopyMode("Close") },

      -- 단어이동
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent', },
      { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine', },
      { key = 'd', mods = 'CTRL', action = act.CopyMode { MoveByPage = 0.5 }, },
      { key = 'e', mods = 'CTRL', action = act.CopyMode { MoveByPage = -0.5 }, },
      
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop', },
      { key = 'g', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom', },
      
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine', },
      { key = 'Escape', mods = 'NONE', action = act.Multiple { { CopyMode = 'MoveToScrollbackBottom' }, { CopyMode = 'Close' }, }, },

      -- 복사 및 종료
      -- { key = "u", action = act.CopyMode("CopyAndClose") },
    },
    search_mode = {
      
      
      -- 기본 'j' (아래로 이동) 동작을 'k' 키로 매핑
      -- { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveDown' }, -- 또는 act.SelectNext
      { key = "k", action = act.CopyMode("MoveDown") },
      
      -- 기본 'k' (위로 이동) 동작을 'l' 키로 매핑
      -- { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveUp' }, -- 또는 act.SelectPrev
      { key = "l", action = act.CopyMode("MoveUp") },
      
      -- 참고: 기본 런처/선택기 UI는 수직 목록인 경우가 많아
      -- 'h'(왼쪽) 와 'l'(오른쪽)에 해당하는 기본 동작이 없을 수 있습니다.
      -- 따라서 아래 매핑은 효과가 없을 수 있습니다.
      -- { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveLeft' }, -- 만약 좌우 이동이 있다면
      -- { key = ';', mods = 'NONE', action = act.CopyMode 'MoveRight' }, -- 만약 좌우 이동이 있다면

      -- (선택) 원치 않는 기본 키 바인딩 비활성화 (예: 원래 j, k)
      { key = 'j', mods = 'NONE', action = act.DisableDefaultAssignment },
      -- { key = 'k', mods = 'NONE', action = act.DisableDefaultAssignment }, -- 이미 위에서 'k'에 새 액션을 할당했으므로 덮어쓰여짐
      -- { key = 'h', mods = 'NONE', action = act.DisableDefaultAssignment },
      -- { key = 'l', mods = 'NONE', action = act.DisableDefaultAssignment }, -- 이미 위에서 'l'에 새 액션을 할당했으므로 덮어쓰여짐

      -- 다른 search_mode 키 바인딩 유지 또는 추가
      -- 예: Enter로 선택, Esc로 취소 등은 기본값을 따르거나 여기서 재정의 가능
      -- { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMode' }, -- 선택 완료 동작 (예시)
      -- { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },   -- 취소 동작 (예시)
    },
}

local plugin_keys = require("plugin")

-- 키 바인딩 합치기
config.keys = {}
for _, k in ipairs(general_keys) do table.insert(config.keys, k) end
for _, k in ipairs(plugin_keys) do table.insert(config.keys, k) end

return config