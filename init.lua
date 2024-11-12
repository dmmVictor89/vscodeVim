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
  use 'jonatan-branting/nvim-better-n'
  use {'nvim-lualine/lualine.nvim',
       requires = { 'nvim-tree/nvim-web-devicons', opt = true }}
  use 'ggandor/leap.nvim'
  use 'ggandor/flit.nvim'
  use 'gbprod/substitute.nvim'
  use 'chrisgrieser/nvim-various-textobjs'
  -- use {
  --   'phaazon/hop.nvim',
  --   branch = 'v2', -- optional but strongly recommended
  --   config = function()
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     require'hop'.setup {
  --       keys = 'hfgetovxqpdyblzhckisuran',
  --       -- hint_char1 = 'j'  -- 기본 j 

  --     }
  --   end
  -- }
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
require('leap').setup{}
---------------------------------------------------------------------------------------------------------
require('flit').setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "v",
  -- Repeat with the trigger key itself.
  clever_repeat = true,
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {}
}
---------------------------------------------------------------------------------------------------------
require('substitute').setup({
  highlight_substituted_text = {
    enabled = true,
    timer = 5000
  }
})
---------------------------------------------------------------------------------------------------------
require("various-textobjs").setup({ 
  useDefaultKeymaps = true,

	-- display notification if a text object is not found
	notifyNotFound = true,

})
---------------------------------------------------------------------------------------------------------
-- require('hop').setup()
---------------------------------------------------------------------------------------------------------
-- require('leap').opts.safe_labels = {}
---------------------------------------------------------------------------------------------------------
require("keyMapping")
---------------------------------------------------------------------------------------------------------
-- Neovim Ui Modifier
vim.api.nvim_exec([[
    " THEME CHANGER
    function! SetCursorLineNrColorInsert(mode)
        " Insert mode: blue
        if a:mode == "i"
            call VSCodeNotify('nvim-theme.insert')

        " Replace mode: red
        elseif a:mode == "r"
            call VSCodeNotify('nvim-theme.replace')
        endif
    endfunction

    augroup CursorLineNrColorSwap
        autocmd!
        autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
        autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
        autocmd ModeChanged [vV\x16]*:* call VSCodeNotify('nvim-theme.normal')
    augroup END
]], false)
---------------------------------------------------------------------------------------------------------
-- require('leap').create_default_mappings()
-- text-case.nvim: case 변경(upper, lower, snake, dash etc...)