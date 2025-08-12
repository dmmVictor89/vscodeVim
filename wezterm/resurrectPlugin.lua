
local wezterm = require 'wezterm'
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- resurrect json file 경로
-- C:\Users\jinpyo\AppData\Roaming\wezterm\plugins\httpssCssZssZsgithubsDscomsZsMLFlexersZsresurrectsDswezterm\state\
-- 플러그인 위치
-- C:\Users\jinpyo\AppData\Roaming\wezterm\plugins\httpssCssZssZsgithubsDscomsZsMLFlexersZsresurrectsDswezterm\plugin\resurrect

local utils = require("resurrect.utils")
local pane_tree_mod = require("resurrect.pane_tree")
-- wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

local logger = wezterm.plugin.require("https://github.com/sei40kr/wez-logging.git")
-- wez logging 설정은 wez-logging 폴더의 init.lua

local act = wezterm.action


return {

  { key = "l", mods = "ALT|SHIFT", action = logger.action.CaptureScrollback },
  -- { key = "l", mods = "CTRL|ALT|SHIFT",       action = logger.action.CaptureViewport },

  {
    key = "s",
    mods = "ALT",
    action = wezterm.action.Multiple {
      resurrect.tab_state.save_tab_action(),
      wezterm.action_callback(function(window, pane)
        window:toast_notification("Resurrect", "✅ 탭 저장 완료!", nil, 1)
      end),
    },
  },
{
    key = "r",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
        local type = string.match(id, "^([^/]+)") -- match before '/'
        id = string.match(id, "([^/]+)$") -- match after '/'
        id = string.match(id, "(.+)%..+$") -- remove file extention
        local opts = {
          relative = true,
          restore_text = true,
          close_open_panes = true, -- 복원 전에 현재 탭의 모든 pane을 닫고 복원할 pane만 유지함. tab 복원 시 유용.
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        }
        if type == "workspace" then
          local state = resurrect.state_manager.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
          win:toast_notification("Resurrect", "🔄 워크스페이스 복원 완료: " .. id, nil, 1)
        elseif type == "window" then
          local state = resurrect.state_manager.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
                      win:toast_notification("Resurrect", "🪟 윈도우 복원 완료: " .. id, nil, 1)
        elseif type == "tab" then
          local state = resurrect.state_manager.load_state(id, "tab")
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
                      win:toast_notification("Resurrect", "📑 탭 복원 완료: " .. id, nil, 1)
        end
      end)
    end),
  },

    {
    key = "d",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
          resurrect.state_manager.delete_state(id)
          win:toast_notification("Resurrect", "🗑️ 상태 삭제 완료: " .. id, nil, 1)
        end,
        {
          title = "Delete State",
          description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
          fuzzy_description = "Search State to Delete: ",
          is_fuzzy = true,
        })
    end),
  },

}