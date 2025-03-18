print("init.lua load start")
-- 경로
-- 회사용
-- C:\Neovim\bin
-- 경로 설정 직접 가능
-- {
--   "neovim.path": "/path/to/neovim", // 예: "C:/Program Files/Neovim/bin/nvim.exe"
--   "neovim.initVimPaths": ["~/.config/nvim/init.lua"] // init.lua 경로를 지정
-- }

-- init.lua reload
-- :source $MYVIMRC
-- vim restart: ctrl + alt + shift + i 
-- vim stop: ctrl + alt + v

-- 플러그인 업데이트하는 방법
-- :PackerSync

---------------------------------------------------------------------------------------------------------
vim.defer_fn(function()
  vim.o.iminsert = 0
  vim.o.imsearch = 0
end, 100)


-- 기존 packer_compiled.lua 파일 삭제
-- vim.fn.delete(vim.fn.stdpath('config') .. '\\plugin\\packer_compiled.lua')

-- -- Packer 부트스트랩 코드
-- local ensure_packer = function()
--   local fn = vim.fn
--   local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--     vim.cmd [[packadd packer.nvim]]
--     return true
--   end
--   return false
-- end

-- local packer_bootstrap = ensure_packer()


-- packer.nvim 자동 설치 (최적화 버전)
local packer_bootstrap = false
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if not vim.loop.fs_stat(install_path) then
  packer_bootstrap = true
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

---------------------------------------------------------------------------------------------------------
require('packer').startup({function(use)
  -- Your plugins here
  use 'wbthomason/packer.nvim'
  -- use 'tpope/vim-repeat' -- 매크로나 찾기등등을 모두 반복해주는 플러그인
  -- use 'jonatan-branting/nvim-better-n'

  use 'ggandor/leap.nvim'
  use 'ggandor/flit.nvim'
  use 'gbprod/substitute.nvim'
  use 'chrisgrieser/nvim-various-textobjs'
  use 'anuvyklack/hydra.nvim' 
  use("gbprod/yanky.nvim") 

  -- vs code 가 아닐 때만 로드
  if not vim.g.vscode then
  use {'nvim-lualine/lualine.nvim',
       requires = { 'nvim-tree/nvim-web-devicons', opt = true }}
  end

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
-- require("better-n").setup(
--   {
--     -- These are default values, which can be omitted.
--     -- By default, the following mappings are made repeatable using `n` and `<S-n>`:
--     -- `f`, `F`, `t`, `T`, `*`, `#`, `/`, `?`
--     disable_default_mappings = false,
--   }
-- )
---------------------------------------------------------------------------------------------------------
-- vscode 가 아닐 때만 실행 전용
if not vim.g.vscode then 
require('lualine').setup()
  -- use { 'nvim-tree/nvim-web-devicons', opt = true }
require('evil_lualine')
end
---------------------------------------------------------------------------------------------------------
-- vim.keymap.set({ 'i', 'x' }, '<esc>', function()

--   vim.fn.system("im-choice.exe 409")

--   vim.cmd("normal! \27")
-- end, { noremap = true, silent = true })
---------------------------------------------------------------------------------------------------------
local labels = {
    's', 'f', 'n', 'j', 'k', 'l', 'h', 'o', 'd', 'w', 'e', 'm', 'y', 't', 'g', 'i', 'a', 'r', 'c',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    'S', 'F', 'N', 'J', 'K', 'L', 'H', 'O', 'D', 'W', 'E', 'M', 'Y', 'T', 'G', 'I', 'A', 'R', 'C',
    '-', '=', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+'
}

-- Leap 설정에 라벨 적용
require('leap').opts.labels = labels


-- for i = 1, #labels do
--     if labels[i]:match("%l") then  -- 소문자인 경우만 처리
--         for j = 1, #labels do
--             if labels[j]:match("%l") then  -- 두 번째 소문자도 확인
--                 table.insert(labels, labels[i]..labels[j])  -- 두 소문자 조합 추가
--             end
--         end
--     end
-- end
-- local labelsAdd = {
--     'S', 'F', 'N', 'J', 'K', 'L', 'H', 'O', 'D', 'W', 'E', 'M', 'Y', 'T', 'G', 'I', 'A', 'R', 'C',
--     '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
-- }
-- -- 두 레이블 합치기
-- table.insert(labels, labelsAdd)
-- table.remove(labels, 1)

local leap = require("leap")

-- require("leap").add_default_mappings()
leap.add_default_mappings()

-- `t`를 `s`처럼 동작하도록 설정 (화면 전체 검색)
vim.keymap.set({ "n", "x", "o" }, "e", function()
  leap.leap({ target_windows = { vim.fn.win_getid() } })
end, { desc = "Leap using 't'" })

-- leap 가 x(잘라내기)를 점유하지 않도록 설정
vim.api.nvim_del_keymap("x", "x")  -- Visual 모드에서 leap의 x 매핑 제거


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
-- substitute 와 s키 중복 오류로 사용 안 함    
-- require('leap').create_default_mappings()
-- Use the traversal keys to repeat the previous motion without explicitly
-- invoking Leap.
require('leap.user').set_repeat_keys('<tab>, <enter>', '<backspace>')

-- Define equivalence classes for brackets and quotes, in addition to
-- the default whitespace group.
require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
---------------------------------------------------------------------------------------------------------
require('flit').setup {
  keys = { f = 'f', F = 'F' , t = 't', T = 'T' }, -- t는 leap 에서 사용하도록 변경
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
  keymaps = {
    useDefaults = true
  },
  notify = {
    whenObjectNotFound = true
  }
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

-- 히스토리 크기 제한 (Yanky 설정 필요)
vim.g.yanky_max_entries = 50 -- 최대 50개 항목으로 제한 (플러그인 설정에 따라 적용)
---------------------------------------------------------------------------------------------------------
-- require('hop').setup()
---------------------------------------------------------------------------------------------------------
-- require('leap').opts.safe_labels = {}
---------------------------------------------------------------------------------------------------------
require("keyMapping")
-- if vim.g.vscode then 
    -- require("vsCodeKeyMapping")
-- end
---------------------------------------------------------------------------------------------------------
-- text-case.nvim: case 변경(upper, lower, snake, dash etc...)

-- IDE 에 따라서 설정 변경 sample 
-- -- IDE 확인
-- local function is_vscode()
--   return vim.g.vscode ~= nil
-- end

-- local function is_intellij()
--   return vim.g.intellij ~= nil
-- end

-- -- 공통 설정
-- -- 여기에 모든 환경에서 사용할 설정을 작성합니다

-- -- VSCode 전용 설정
-- if is_vscode() then
  -- VSCode Neovim 확장에서 사용할 설정을 여기에 작성합니다
  -- vim.g.mapleader = " "
  -- VSCode 전용 키 매핑 등
-- end

-- -- IntelliJ 전용 설정
-- if is_intellij() then
--   -- IntelliJ에서 IdeaVim 또는 Neovim 플러그인을 사용할 때의 설정을 여기에 작성합니다
--   vim.opt.clipboard = "unnamedplus"
--   -- IntelliJ 전용 키 매핑 등
-- end

-- -- Neovim 단독 실행 시 설정
-- if not is_vscode() and not is_intellij() then
--   -- Neovim을 단독으로 실행할 때 사용할 설정을 여기에 작성합니다
--   require('plugins')
--   -- 플러그인 설정 등
-- end