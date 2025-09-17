-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\MyProgramFiles\\msys64\\tmp\\nvim\\packer_hererocks\\2.1.1741730670\\share\\lua\\5.1\\?.lua;C:\\MyProgramFiles\\msys64\\tmp\\nvim\\packer_hererocks\\2.1.1741730670\\share\\lua\\5.1\\?\\init.lua;C:\\MyProgramFiles\\msys64\\tmp\\nvim\\packer_hererocks\\2.1.1741730670\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\MyProgramFiles\\msys64\\tmp\\nvim\\packer_hererocks\\2.1.1741730670\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\MyProgramFiles\\msys64\\tmp\\nvim\\packer_hererocks\\2.1.1741730670\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["flit.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tflit\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\flit.nvim",
    url = "https://github.com/ggandor/flit.nvim"
  },
  ["hydra.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hydra.nvim",
    url = "https://github.com/anuvyklack/hydra.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\25add_default_mappings\tleap\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["neo-tree.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-biscuits"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-biscuits",
    url = "https://github.com/code-biscuits/nvim-biscuits"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-various-textobjs"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21various-textobjs\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-various-textobjs",
    url = "https://github.com/chrisgrieser/nvim-various-textobjs"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["smear-cursor.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\smear-cursor.nvim",
    url = "https://github.com/sphamba/smear-cursor.nvim"
  },
  ["substitute.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15substitute\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\substitute.nvim",
    url = "https://github.com/gbprod/substitute.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nÐ\5\0\0\t\0\24\00096\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1€K\0\1\0006\2\1\0'\4\3\0B\2\2\0029\2\4\0025\4\6\0005\5\5\0=\5\a\0045\5\b\0=\5\t\4B\2\2\0016\2\1\0'\4\3\0B\2\2\0029\2\4\0025\4\v\0005\5\n\0=\5\a\0045\5\f\0=\5\t\4B\2\2\0019\2\4\0015\4\20\0005\5\14\0005\6\r\0=\6\15\0055\6\17\0004\a\3\0005\b\16\0>\b\1\a=\a\18\6=\6\19\5=\5\21\4B\2\2\0016\2\0\0009\4\22\1'\5\15\0B\2\3\0016\2\1\0'\4\2\0B\2\2\0029\2\22\2'\4\23\0B\2\2\0016\2\1\0'\4\2\0B\2\2\0029\2\22\2'\4\19\0B\2\2\1K\0\1\0\rprojects\19load_extension\15extensions\1\0\1\15extensions\0\fproject\14base_dirs\1\0\4\14base_dirs\0\17hidden_files\2\rorder_by\basc\ntheme\rdropdown\1\2\1\0\18C:\\nworkspace\14max_depth\3\2\bfzf\1\0\2\fproject\0\bfzf\0\1\0\4\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\1\4\0\0\t.git\f.gradle\t.svn\1\0\3\22detection_methods\0\16show_hidden\2\rpatterns\0\1\3\0\0\fpattern\blsp\rpatterns\1\4\0\0\t.git\rMakefile\17package.json\22detection_methods\1\0\2\22detection_methods\0\rpatterns\0\1\3\0\0\fpattern\blsp\nsetup\17project_nvim\14telescope\frequire\npcall\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n\\\0\0\3\0\6\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0'\1\5\0=\1\4\0K\0\1\0\tdark\15background\6o\27colorscheme tokyonight\bcmd\bvim\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["yanky.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nyanky\frequire\0" },
    loaded = true,
    path = "C:\\Users\\jinpyo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\yanky.nvim",
    url = "https://github.com/gbprod/yanky.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: yanky.nvim
time([[Config for yanky.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nyanky\frequire\0", "config", "yanky.nvim")
time([[Config for yanky.nvim]], false)
-- Config for: flit.nvim
time([[Config for flit.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tflit\frequire\0", "config", "flit.nvim")
time([[Config for flit.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nÐ\5\0\0\t\0\24\00096\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1€K\0\1\0006\2\1\0'\4\3\0B\2\2\0029\2\4\0025\4\6\0005\5\5\0=\5\a\0045\5\b\0=\5\t\4B\2\2\0016\2\1\0'\4\3\0B\2\2\0029\2\4\0025\4\v\0005\5\n\0=\5\a\0045\5\f\0=\5\t\4B\2\2\0019\2\4\0015\4\20\0005\5\14\0005\6\r\0=\6\15\0055\6\17\0004\a\3\0005\b\16\0>\b\1\a=\a\18\6=\6\19\5=\5\21\4B\2\2\0016\2\0\0009\4\22\1'\5\15\0B\2\3\0016\2\1\0'\4\2\0B\2\2\0029\2\22\2'\4\23\0B\2\2\0016\2\1\0'\4\2\0B\2\2\0029\2\22\2'\4\19\0B\2\2\1K\0\1\0\rprojects\19load_extension\15extensions\1\0\1\15extensions\0\fproject\14base_dirs\1\0\4\14base_dirs\0\17hidden_files\2\rorder_by\basc\ntheme\rdropdown\1\2\1\0\18C:\\nworkspace\14max_depth\3\2\bfzf\1\0\2\fproject\0\bfzf\0\1\0\4\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\1\4\0\0\t.git\f.gradle\t.svn\1\0\3\22detection_methods\0\16show_hidden\2\rpatterns\0\1\3\0\0\fpattern\blsp\rpatterns\1\4\0\0\t.git\rMakefile\17package.json\22detection_methods\1\0\2\22detection_methods\0\rpatterns\0\1\3\0\0\fpattern\blsp\nsetup\17project_nvim\14telescope\frequire\npcall\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\25add_default_mappings\tleap\frequire\0", "config", "leap.nvim")
time([[Config for leap.nvim]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n\\\0\0\3\0\6\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0'\1\5\0=\1\4\0K\0\1\0\tdark\15background\6o\27colorscheme tokyonight\bcmd\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: nvim-various-textobjs
time([[Config for nvim-various-textobjs]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21various-textobjs\frequire\0", "config", "nvim-various-textobjs")
time([[Config for nvim-various-textobjs]], false)
-- Config for: substitute.nvim
time([[Config for substitute.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15substitute\frequire\0", "config", "substitute.nvim")
time([[Config for substitute.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
