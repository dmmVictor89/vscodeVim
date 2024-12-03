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
  use("gbprod/yanky.nvim") 
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
local labels = {
    's', 'f', 'n', 'j', 'k', 'l', 'h', 'o', 'd', 'w', 'e', 'm', 'y', 't', 'g', 'i', 'a', 'r', 'c',
}
for i = 1, #labels do
    if labels[i]:match("%l") then  -- 소문자인 경우만 처리
        for j = 1, #labels do
            if labels[j]:match("%l") then  -- 두 번째 소문자도 확인
                table.insert(labels, labels[i]..labels[j])  -- 두 소문자 조합 추가
            end
        end
    end
end
local labelsAdd = {
    'S', 'F', 'N', 'J', 'K', 'L', 'H', 'O', 'D', 'W', 'E', 'M', 'Y', 'T', 'G', 'I', 'A', 'R', 'C',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
}
-- 두 레이블 합치기
table.insert(labels, labelsAdd)

require('leap').setup{
    labels = labels,
    equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' },
    special_keys = {
      -- next_target = '<;>',
      next_target = '<Tab>',
      prev_target = '<S-Tab>',
      next_group = '<Enter>',
      prev_group = '<S-Enter>',
      multi_accept = '<CR>',
      multi_revert = '<BS>',
    },
}
require('leap').create_default_mappings()
-- Use the traversal keys to repeat the previous motion without explicitly
-- invoking Leap.
require('leap.user').set_repeat_keys('<tab>, <enter>', '<backspace>')

-- Define equivalence classes for brackets and quotes, in addition to
-- the default whitespace group.
require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
---------------------------------------------------------------------------------------------------------
require('flit').setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- keys = { f = 'f', F = 'F', t = 'z', T = 'Z' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "v",
  -- Repeat with the trigger key itself.
  clever_repeat = true,
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {},
 -- u를 제외하기 위해서 flit.lua 에서 //241118 u 제외 목록에 추가
  labels = labels,
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
require("yanky").setup({
  ring = {
    history_length = 100,
    storage = "shada",
    storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
    sync_with_numbered_registers = true,
    cancel_event = "update",
    ignore_registers = { "_" },
    update_register_on_cycle = false,
    permanent_wrapper = nil,
  },
  picker = {
    select = {
      action = nil, -- nil to use default put action
    },
    telescope = {
      use_default_mappings = true, -- if default mappings should be used
      mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
    },
  },
  system_clipboard = {
    sync_with_ring = true,
    clipboard_register = nil,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  preserve_cursor_position = {
    enabled = true,
  },
  textobj = {
   enabled = true,
  },
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
-- text-case.nvim: case 변경(upper, lower, snake, dash etc...)