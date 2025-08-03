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
--- 인코딩 설정
---------------------------------------------------------------------------------------------------------
---
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = { "*.pc" },
  callback = function()
    -- 인코딩 탐색 순서: euc-kr 먼저, cp949, utf-8 순으로 시도
    vim.opt_local.fileencodings = { "euc-kr", "cp949", "utf-8" }
    -- 탐색 결과에 상관없이 무조건 EUC-KR 로 읽고 싶다면
    vim.opt_local.fileencoding  = "euc-kr"
  end,
})


---------------------------------------------------------------------------------------------------------
if vim.g.vscode then
  vim.schedule(function()
    vim.o.iminsert = 0
    vim.o.imsearch = 0
  end)
end

-- 줄 바꿈(line wrapping) 기능 비활성화
vim.o.wrap = false
-- 또는 vim.opt 네임스페이스 사용:
-- vim.opt.wrap = false

-- (선택 사항, 권장) 자동 들여쓰기 활성화
-- vim.o.autoindent = true
-- vim.o.smartindent = true -- 또는 파일 타입별 설정을 위해 아래 사용
-- vim.cmd('filetype plugin indent on') -- 파일 타입에 맞는 들여쓰기 자동 로드


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

-- Packer 설치 여부를 캐시로 확인
local function ensure_packer()
  if vim.g.packer_installed ~= nil then return vim.g.packer_installed end
  if not vim.loop.fs_stat(install_path) then
    packer_bootstrap = true
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd("packadd packer.nvim")
    vim.g.packer_installed = true
  else
    vim.g.packer_installed = false
  end
  return packer_bootstrap
end

packer_bootstrap = ensure_packer()

---------------------------------------------------------------------------------------------------------
---https://github.com/akiyosi/goneovim todo: gui 버전의 neovim 한번 사용해 보기
require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'
    use { 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings() end }
    use { 'ggandor/flit.nvim', config = function() require('flit').setup() end }
    use { 'gbprod/substitute.nvim', config = function() require('substitute').setup() end }
    use { 'chrisgrieser/nvim-various-textobjs'
    -- , event = "BufEnter" -- lazy loading 
    , config = function() require("various-textobjs").setup() end }
    use { 'anuvyklack/hydra.nvim'
    -- , opt = true, cmd = "Hydra" -- lazy loading
   }
    use { 'gbprod/yanky.nvim'
    -- , event = "TextYankPost" -- lazy loading
    , config = function() require("yanky").setup() end }

    -- 중괄호 표시
    use {
      'code-biscuits/nvim-biscuits',
      requires = {
        'nvim-treesitter/nvim-treesitter',
        run = ':SUpdate'
      },
    }

    if not vim.g.vscode then
      use { 'sphamba/smear-cursor.nvim' }
      use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }, config = function() require('lualine').setup() end }
      
      -- 컬러테마 플러그인 추가 (예: tokyonight)
      use { 'folke/tokyonight.nvim'
        , config = function()
          -- Packer가 플러그인을 로드한 후 실행될 코드
          -- Neovim 시작 시 이 테마를 적용
          vim.cmd('colorscheme tokyonight')
          -- 배경 설정 (옵션)
          vim.o.background = 'dark'
        end
      }

      -- 주석 처리 comment
      use { 'numToStr/Comment.nvim'
           , config = function()
             require('Comment').setup()
             end
      }

      -- 중괄호 표시
      use {
        'code-biscuits/nvim-biscuits',
        requires = {
          'nvim-treesitter/nvim-treesitter',
          run = ':SUpdate'
        },
      }

    end

    if packer_bootstrap then require('packer').sync() end
  end,
  config = {
    display = { open_fn = function() return require('packer.util').float({ border = 'single' }) end }
  }
})

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
-- swapfile, backup 을 사용하지 않을 때 성능을 위해서 꺼두는게 좋음
-- vim.opt.swapfile = false
-- vim.opt.backup = false

---------------------------------------------------------------------------------------------------------
-- 들여쓰기 및 탭 관련 설정 (스페이스 4칸 사용)
vim.opt.expandtab = true

-- 탭 하나를 4개의 스페이스로 설정
vim.opt.tabstop = 4

-- 들여쓰기/내어쓰기 시 스페이스 4개 사용
vim.opt.shiftwidth = 4

-- 탭 입력 시 스페이스 4개 삽입
vim.opt.softtabstop = 4

-- 들여쓰기를 shiftwidth의 배수로 맞춤 (선택 사항)
vim.opt.shiftround = true

---------------------------------------------------------------------------------------------------------
-- 입력 지연 관련 설정
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 15000  -- 키 코드 처리 대기 시간을 10ms로 설정

---------------------------------------------------------------------------------------------------------
-- vim.keymap.set({ 'i', 'x' }, '<esc>', function()

--   vim.fn.system("im-choice.exe 409")

--   vim.cmd("normal! \27")
-- end, { noremap = true, silent = true })
---------------------------------------------------------------------------------------------------------
local leap = require("leap")

local labels = {
    's', 'f', 'n', 'j', 'k', 'l', 'h', 'o', 'd', 'w', 'e', 'm', 'y', 't', 'g', 'i', 'a', 'r', 'c',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    'S', 'F', 'N', 'J', 'K', 'L', 'H', 'O', 'D', 'W', 'E', 'M', 'Y', 'T', 'G', 'I', 'A', 'R', 'C',
    '-', '=', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+'
}

-- Leap 설정에 라벨 적용
leap.opts.labels = labels

leap.add_default_mappings()

-- `t`를 `s`처럼 동작하도록 설정 (화면 전체 검색)
vim.keymap.set({ "n", "x", "o" }, "e", function()
  leap.leap({ target_windows = { vim.fn.win_getid() } })
end, { desc = "Leap using 't'" })

-- leap 가 x(잘라내기)를 점유하지 않도록 설정
vim.api.nvim_del_keymap("x", "x")  -- Visual 모드에서 leap의 x 매핑 제거


leap.setup{
    labels = labels,
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
leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
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
  opts = {
  },
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
-- ============================================================================
-- 플러그인 개별 설정
-- ============================================================================

-- smear-cursor.nvim 설정 (VSCode가 아닐 때만)
if not vim.g.vscode then
    require('smear_cursor').setup({
        -- 기본 설정
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        legacy_computing_symbols_support = false,
        
        -- 커서 색상 (터미널이 색상을 덮어쓰는 경우 수동 설정)
        -- cursor_color = "#d3cdc3",  -- 또는 "none"으로 텍스트 색상 매칭
        cursor_color = "#673AB7",  -- 또는 "none"으로 텍스트 색상 매칭
        
        -- 애니메이션 조정 (더 빠르게 하려면)
        stiffness = 0.8,                      -- 0.6      [0, 1]
        trailing_stiffness = 0.5,             -- 0.4      [0, 1]
        stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
        trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
        damping = 0.8,                        -- 0.65     [0, 1]
        damping_insert_mode = 0.8,            -- 0.7      [0, 1]
        distance_stop_animating = 0.5,        -- 0.1      > 0
        
        -- 프레임레이트 조정
        time_interval = 7, -- 밀리초 (기본값: 17ms)
        
        -- 인서트 모드에서도 스미어 활성화
        smear_insert_mode = true,
        
        -- 최소 이동 거리 설정
        min_horizontal_distance_smear = 1,
        min_vertical_distance_smear = 1,
    })
end
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
