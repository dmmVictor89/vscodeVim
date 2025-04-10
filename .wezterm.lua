
local wezterm = require 'wezterm'
local act = wezterm.action

-- 환경구분을 위해서 hostname 호출
-- home: DESKTOP-LEKLO7C
local hostname = wezterm.hostname()

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
config.font = wezterm.font("D2Coding")
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
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher, },

  -- 로깅
  { key = 'L', mods = 'CTRL|ALT', action = wezterm.action.TogglePaneLogging, },

}

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