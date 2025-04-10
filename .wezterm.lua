
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

local panel = require("wezterm_panel")
require("plugin")


local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)


local config = wezterm.config_builder()

config.default_prog = { prog, "-l" }
config.font_size = 12.0
config.font = wezterm.font_with_fallback({
  "D2Coding",
  "JetBrains Mono",
  "Noto Sans",
})
config.color_scheme = 'Catppuccin Mocha'

config.leader = { mods = "CTRL", key = " ", timeout_milliseconds = 2000, }

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
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher,
    },

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
    window:toast_notification("WezTerm", "✅ Log saved between last two markers", nil, 3000)
  else
    window:toast_notification("WezTerm", "❌ Failed to save log file", nil, 3000)
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
}

local plugin_keys = require("plugin")

-- 키 바인딩 합치기
config.keys = {}
for _, k in ipairs(general_keys) do table.insert(config.keys, k) end
for _, k in ipairs(plugin_keys) do table.insert(config.keys, k) end

return config