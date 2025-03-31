-- wezterm.lua의 상단에 추가
package.path = package.path .. ";C:/Users/이진표/AppData/Local/nvim/?.lua"

local panel = require("wezterm_panel")

local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on('window-config-reloaded', function(window, pane)
  window:toast_notification("wezterm", "Config reloaded!", nil, 4000)
end)

-- require(".wezterm_panel")


return {
  default_prog = { "C:\\My Program Files\\Git\\bin\\bash.exe", "-l"},

  font_size = 12.0,
  font = wezterm.font("D2Coding"),
  color_scheme = 'Catppuccin Mocha',

  -- leader 키 설정
  leader = { mods = "CTRL", key = " ", timeout_milliseconds = 2000 },

  keys = {

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

    
  },

  key_tables = {
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
  },

}
