-- 경로
-- 회사용
-- C:\Neovim\bin
-- 경로 설정 직접 가능
-- {
--   "neovim.path": "/path/to/neovim", // 예: "C:/Program Files/Neovim/bin/nvim.exe"
--   "neovim.initVimPaths": ["~/.config/nvim/init.lua"] // init.lua 경로를 지정
-- }


-- 기존 packer_compiled.lua 파일 삭제
vim.fn.delete(vim.fn.stdpath('config') .. '\\plugin\\packer_compiled.lua')

-- Packer 부트스트랩 코드
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

---------------------------------------------------------------------------------------------------------
require('packer').startup({function(use)
  -- Your plugins here
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-repeat' -- 매크로나 찾기등등을 모두 반복해주는 플러그인
  use "jonatan-branting/nvim-better-n"
  use {'nvim-lualine/lualine.nvim',
       requires = { 'nvim-tree/nvim-web-devicons', opt = true }}
  use 'ggandor/leap.nvim'
  use {
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran'
    -- multi_windows = true
  }
  end
  }
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
---------------------------------------------------------------------------------------------------------
require("better-n").setup(
  {
    -- These are default values, which can be omitted.
    -- By default, the following mappings are made repeatable using `n` and `<S-n>`:
    -- `f`, `F`, `t`, `T`, `*`, `#`, `/`, `?`
    disable_default_mappings = false,
  }
)
---------------------------------------------------------------------------------------------------------
require('lualine').setup()
require('evil_lualine')
---------------------------------------------------------------------------------------------------------
require('hop').setup()
---------------------------------------------------------------------------------------------------------

require("keyMapping")

-- require('leap').create_default_mappings( )

-- vim message 를 output 에 출력하지 않도록 설정
-- if vim.g.vscode then
--   cmdheight = 1 -- this is the new line I added
--   return
-- end