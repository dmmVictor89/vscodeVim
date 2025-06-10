
local wezterm = require 'wezterm'
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- resurrect json file 경로
-- C:\Users\이진표\AppData\Roaming\wezterm\plugins\httpssCssZssZsgithubsDscomsZsMLFlexersZsresurrectsDswezterm\state\
-- 플러그인 위치
-- C:\Users\이진표\AppData\Roaming\wezterm\plugins\httpssCssZssZsgithubsDscomsZsMLFlexersZsresurrectsDswezterm\plugin\resurrect
local pane_tree_mod = require("resurrect.pane_tree")
wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

local logger = wezterm.plugin.require("https://github.com/sei40kr/wez-logging.git")
-- wez logging 설정은 wez-logging 폴더의 init.lua

local act = wezterm.action


local function get_tab_state(tab)
	local panes = tab:panes_with_info()

	local function is_zoomed()
		for _, pane in ipairs(panes) do
			if pane.is_zoomed then
				return true
			end
		end
		return false
	end

	local tab_state = {
		title = tab:get_title(),
		is_zoomed = is_zoomed(),
		pane_tree = pane_tree_mod.create_pane_tree(panes),
	}

	return tab_state

end


return {

  { key = "l", mods = "ALT|SHIFT", action = logger.action.CaptureScrollback },
  -- { key = "l", mods = "CTRL|ALT|SHIFT",       action = logger.action.CaptureViewport },


{
  key = 's',
  mods = 'ALT',
  action = wezterm.action_callback(function(window, pane)
    -- C:\Users\이진표\AppData\Roaming\wezterm\plugins\httpssCssZssZsgithubsDscomsZsMLFlexersZsresurrectsDswezterm\plugin\resurrect\tab_state.luaC:\Users\이진표\AppData\Roaming\wezterm\plugins\httpssCssZssZsgithubsDscomsZsMLFlexersZsresurrectsDswezterm\plugin\resurrect\tab_state.lua
    -- function pub.save_tab_action()
--  
    local pub = {}

    local ws = resurrect.workspace_state.get_workspace_state()

		local tab = pane:tab()
    local title = ws.workspace
    wezterm.log_info("-------------------------- workspace: " .. wezterm.json_encode(ws) )
    wezterm.log_info("-------------------------- title: " .. ws.workspace)

    local state = get_tab_state(tab)
    wezterm.log_info("-------------------------- state: " .. wezterm.json_encode(state))
    state.title = title
    resurrect.state_manager.save_state(state)
    
    resurrect.tab_state.save_tab_action();
    window:toast_notification('Resurrect', 'Tab 저장됨 ✅', nil, 100);
  end
  ),
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
          wezterm.log_info("stat: " .. wezterm.json_encode(state))
          wezterm.log_info("Current pane_id: " .. tostring(pane:pane_id()))
          resurrect.workspace_state.restore_workspace(state, opts)
        elseif type == "window" then
          local state = resurrect.state_manager.load_state(id, "window")
          wezterm.log_info("stat: " .. wezterm.json_encode(state))
          wezterm.log_info("Current pane_id: " .. tostring(pane:pane_id()))
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "tab" then
          local state = resurrect.state_manager.load_state(id, "tab")
          wezterm.log_info("stat: " .. wezterm.json_encode(state))
          wezterm.log_info("Current pane_id: " .. tostring(pane:pane_id()))
          
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
        end
      end)
    end),
  },

}