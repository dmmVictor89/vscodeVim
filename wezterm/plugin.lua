
local wezterm = require 'wezterm'

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

-- print("resurrect load start")
-- wezterm.on('window-config-reloaded', function(window, pane)
--   window:toast_notification("Resurrect", "test", nil, 4000)
-- end)

-- local config = wezterm.config_builder()

return {
  {
      key = "s",
      mods = "ALT",
      action = wezterm.action.PromptInputLine {
        description = "워크스페이스 이름을 입력하세요 (예: my-workspace):",
        action = wezterm.action_callback(function(window, pane, line)
          -- 입력이 없거나 취소되면 종료
          if not line or line == "" then
            window:toast_notification("Resurrect", "저장 취소됨 🚫", nil, 100)
            return
          end

          -- 워크스페이스 이름 정규화 (공백 제거, 파일명 안전하게)
          local workspace_name = line:gsub("%s+", "-"):gsub("[^%w%-]", "")

          -- 워크스페이스 상태 저장
          local state = resurrect.workspace_state.get_workspace_state()
          resurrect.state_manager.save_state(state, "workspace", workspace_name)

          -- 저장 완료 알림
          window:toast_notification("Resurrect", "워크스페이스 저장 완료 ✅: " .. workspace_name, nil, 100)
        end),
      }
  },
  -- {
  --   key = "s",
  --   mods = "ALT",
  --   action = wezterm.action_callback(function(win, pane)
  --     resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
  --     win:toast_notification("Resurrect", "워크스페이스 저장 완료 ✅", nil, 100)
  --   end),
  -- },

  {
  key = "r",
  mods = "ALT",
  action = wezterm.action_callback(function(win, pane)
    resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
      local type = string.match(id, "^([^/]+)") -- match before '/'
      id = string.match(id, "([^/]+)$") -- match after '/'
      id = string.match(id, "(.+)%..+$") -- remove file extension
      local opts = {
        window = pane:window(),
        on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        relative = true,
        restore_text = true,
      }
      if type == "workspace" then
        local state = resurrect.state_manager.load_state(id, "workspace")
        resurrect.workspace_state.restore_workspace(state, opts)
      elseif type == "window" then
        local state = resurrect.state_manager.load_state(id, "window")
        resurrect.window_state.restore_window(pane:window(), state, opts)
      elseif type == "tab" then
        local state = resurrect.state_manager.load_state(id, "tab")
        resurrect.tab_state.restore_tab(pane:tab(), state, opts)
      end
      win:toast_notification("Resurrect", "워크스페이스 복원 완료 🔄 type: " .. type, nil, 100)
    end)
  end),
  },
  --[[{
    key = "r",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
      
      resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
        local type = string.match(id, "^([^/]+)") -- match before '/'
        id = string.match(id, "([^/]+)$") -- match after '/'
        id = string.match(id, "(.+)%..+$") -- remove file extention
        -- local opts = {
        --   relative = true,
        --   restore_text = true,
        --   on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        -- }
        
        local opts = {
          window = pane:window(),
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          relative = true,
          restore_text = true,
        }
        if type == "workspace" then
          local state = resurrect.state_manager.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
        elseif type == "window" then
          local state = resurrect.state_manager.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "tab" then
          local state = resurrect.state_manager.load_state(id, "tab")
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
        end

        win:toast_notification("Resurrect", "워크스페이스 복원 완료 🔄 type: ".. type, nil, 100)
      end)
    end),
  }, ]]
}