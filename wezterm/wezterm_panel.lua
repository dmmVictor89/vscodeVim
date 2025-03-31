local wezterm = require("wezterm")

local M = {}

M.launch_menu = {
  {
    label = "🖥️  snlnas",
    args = { "ssh", "shackle89@183.98.219.170:2055" },
  },
  -- {
  --   label = "🔧  staging",
  --   args = { "ssh", "admin@staging.example.com" },
  -- },
  -- {
  --   label = "🌐  prod",
  --   args = { "ssh", "root@prod.example.com" },
  -- },
}
  
-- GUI 시작 시 메뉴 띄우는 함수
M.show_launcher_on_startup = function()
  wezterm.on("gui-startup", function()
    wezterm.gui.spawn_launcher_menu()
  end)
end

return M


