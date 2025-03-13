print("vim on")
--todo //test
-- h 매핑 g로 변경 hjkl 에는 매핑을 안 해야 한다 h 입력을 기다리면서 렉 걸림

-- 새로운 줄에서 제일 앞으로 가지 않도록 함
-- vim.opt.virtualedit = "onemore"
vim.opt.virtualedit = "onemore"

-- <leader> key
vim.g.mapleader = ' '

-- 키 입력 대기 시간 설정 (밀리초 단위)
-- vim.o.timeoutlen = 1000  -- 기본값은 1000
-- -- 키 입력 타임아웃 설정 (밀리초 단위)
vim.o.timeoutlen = 300

-- use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- search ignoring case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- open config
vim.cmd('nmap <leader>cf :e C:\\Users\\이진표\\AppData\\Local\\nvim\\init.lua')

-- save
-- vim.cmd('nmap <leader>s :w<cr>')

-- J key binding 없애기
vim.keymap.set({ 'n', 'v' }, 'J', '')

-- shift + k binding 없애기
vim.keymap.set({ 'i' }, '<s-k>', '')

-- shift + a binding
-- vim.keymap.set({'n', 'v'}, '<s-a>', '<s-v>')

vim.keymap.set({ 'n', 'v' }, 'vv', '<s-v>')

-- <leader> 키 set---------------------------------------------------------------------------------------------------------
-- vscode 명령어로 창 이동
-- vim.keymap.set({'n', 'v'}, '<leader>u', '0')
vim.keymap.set({ 'n', 'v' }, '<leader>u', '<s-i>')
vim.keymap.set({ 'n', 'v' }, '<leader>i', '<s-a>')
vim.keymap.set({ 'n', 'v' }, '-', '$')
vim.keymap.set({ 'n', 'v' }, '<leader>a', '<s-a>')

-- 아래에 새로운 행 만들고 노멀모드
-- vim.api.nvim_set_keymap('n', '<leader>o', 'o<esc>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'o', 'o<Esc>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'O', 'O<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'o', '$a<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', 'o<Esc>0"_D', { noremap = true, silent = true })

-- join lines
vim.api.nvim_set_keymap('n', '<leader>j', 'J', { noremap = true, silent = true })
-- ---------------------------------------------------------------------------------------------------------
-- motion keys (left, down, up, left)
vim.keymap.set({ 'n', 'v' }, 'j', 'h')
vim.keymap.set({ 'n', 'v' }, 'k', 'j')
vim.keymap.set({ 'n', 'v' }, 'l', 'k')
vim.keymap.set({ 'n', 'v' }, ';', 'l')
vim.keymap.set({ 'n', 'v' }, 'h', ';')
-- vim.keymap.set({'n', 'v'}, 'h', '\'')



-- y -> u set yank
vim.keymap.set({ 'n', 'v' }, 'y', 'u')
-- u -> y set undo
-- vim.keymap.set({'n', 'v'}, 'u', 'y')
-- vim.keymap.set({'n', 'v'}, 'uu', 'yy')

-- yu로 yiw 날리기
vim.keymap.set({ 'n', 'v' }, 'uj', 'yiw')

vim.keymap.set({ 'n', 'x' }, 'u', '<Plug>(YankyYank)')
vim.keymap.set({ 'n', 'x' }, 'uu', function()
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'n' then
    -- normal 모드에서는 현재 라인을 선택
    vim.cmd('normal! V')
  end
  -- YankyYank 실행
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(YankyYank)', true, true, true), 'x')
end, { noremap = true, silent = true })

vim.keymap.set({ 'n', 'v' }, '<pageup>', '<c-e>')
vim.keymap.set({ 'n', 'v' }, '<pagedown>', '<c-d>')

-- repeat prvious f, t, F or T movement
-- vim.keymap.set('n', '\'', ';')

-- paste without overwriting
-- vim.keymap.set('v', 'p', 'P')
-- vim.keymap.set({ 'n', 'v', 'x'}, "p", '_dP')

-- redo
vim.keymap.set('n', 'Y', '<C-r>')

-- skip folds (down, up)
-- vim.cmd('nmap j gj')
-- vim.cmd('nmap k gk')

-- :nohlsearch, :noh : serach 하이라이트 끄기
vim.api.nvim_set_keymap('n', 'st', ':noh<CR>', { noremap = true, silent = true })

-- window
-- 윈도우 관련

-- 윈도우 나누기
vim.api.nvim_set_keymap('n', 'sg', ':split<Return>', { silent = true })
vim.api.nvim_set_keymap('n', 'sv', ':vsplit<Return>', { silent = true })


-- -- 창 크기 조절
-- vim.api.nvim_set_keymap('n', 's=', '<c-w>>', { noremap = true, silent = true })
-- vim.keymap.set('n', 's1', '<C-w>>', { noremap = true, silent = true })
-- vim.keymap.set('n', 's=', '<c-w>>')
-- vim.keymap.set('n', 's-', '<c-w><')
-- vim.keymap.set('n', 's<up>', '')
-- vim.keymap.set('n', 's<PageDown>', '')

-- -- 증가 / 감소
vim.keymap.set('n', 'g+', '<c-a>')
vim.keymap.set('n', 'g-', '<c-x>')


-- change the window
-- <leader>w를 <C-w>로 매핑, 명령어가 표시되도록 silent = false 설정
-- vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>', { noremap = true, silent = false })

-- 창 이동을 위한 <leader>w 이후 j, k, l, ; 매핑
-- vim.keymap.set('n', '<leader>w', '<C-w>w', { noremap = true }) -- j -> h (왼쪽)
-- vim.api.nvim_set_keymap('n', '<leader>w1', '<Cmd>1wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w2', '<Cmd>2wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w3', '<Cmd>3wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w4', '<Cmd>4wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w5', '<Cmd>5wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w6', '<Cmd>6wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w7', '<Cmd>7wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w8', '<Cmd>8wincmd w<CR>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>w9', '<Cmd>9wincmd w<CR>', { noremap = true, silent = false })

-- Delete related settings in Lua

-- If leader key with 'd' is pressed, delete and store in clipboard
-- vim.keymap.set('n', '<leader>d', '"+d')

-- If just 'd' is pressed in normal mode, do not store in clipboard
vim.keymap.set({ 'n', 'v' }, 'd', '"_d')

-- If just 'd' is pressed in visual mode, do not store in clipboard
-- vim.keymap.set('v', 'd', '"_d')

vim.keymap.set({ 'n', 'v' }, 'x', '"_x')

-- Delete to the end
vim.keymap.set({ 'n', 'v' }, 'D', '"_D')




-- Ctrl+e 가 diw 로 동작
vim.keymap.set('v', '<c-e>', '"_diw')

-- multiple line mode
vim.keymap.set({ 'n', 'v' }, '<leader>v', '<c-v>')

-- ---------------------------------------------------------------------------------------------------------
-- set line number
-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true

-- Create an augroup for toggling relative and absolute numbers
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- Switch to absolute number after cursor movement
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = numbertoggle,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Map <leader> to also toggle relativenumber while preserving its functionality
vim.keymap.set({ 'n', 'v' }, '`', function()
  vim.opt.relativenumber = false -- 리더 키를 눌렀을 때 relativenumber 활성화
  -- vim.cmd('redraw')              -- 화면 즉시 다시 그리기
  -- return '<leader>'              -- 리더 키의 원래 기능 유지
end, { expr = true })

-- ---------------------------------------------------------------------------------------------------------
-- 마킹 관련
vim.keymap.set({ 'n', 'v' }, '<leader>m', '`m')
-- 커서를 정확한 위치로 이동시키기 위해 `(백틱)을 '(작은 따옴표) 로 변경
vim.keymap.set({ 'n', 'v' }, '\'', '`')


-- ---------------------------------------------------------------------------------------------------------
-- vscode 전용
-- vscode 인지 판단
if vim.g.vscode then 
  -- vscode 
  print("vscode setting is loaded")

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

    -- VSCode 환경에서 사용할 keymapping 설정 로드
    vim.api.nvim_set_keymap('n', '0', ':call VSCodeNotify("cursorHome")<CR>', { noremap = true, silent = true })

    -- close window
    vim.keymap.set('n', '<leader>x', function()
      local win_count = #vim.api.nvim_list_wins()                   -- 현재 열린 창의 개수
      if win_count > 1 then
        vim.fn.VSCodeNotify('workbench.action.closeActiveEditor')   -- VSCode의 창 닫기 명령 호출
      end
    end, { noremap = true, silent = true })

    -- jj -> esc
    -- vim.keymap.set('i', 'jj', '<Esc>')
    -- vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })
    -- Insert 모드에서 'jj'를 눌렀을 때 Esc로 전환
    -- vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true, nowait = true })
    -- vim.api.nvim_set_keymap('i', 'jj', ':call VSCodeNotify("vscode-neovim.escape")<CR>', { noremap = true, silent = true, nowait = true })
    -- vscode-neovim.escape
    -- 'jj' 입력 시 메시지 표시
    -- vim.api.nvim_set_keymap('i', 'kk', '<Esc>:echo "모드 전환됨"<CR>', { noremap = true, silent = true })

    -- 탭 이동
    vim.api.nvim_set_keymap('n', 'gt', ':call VSCodeNotify("workbench.action.nextEditor")<CR>',
      { noremap = true, silent = true, nowait = true })
    vim.api.nvim_set_keymap('n', 'gr', ':call VSCodeNotify("workbench.action.previousEditor")<CR>',
      { noremap = true, silent = true, nowait = true })


    -- 윈도우 관련

    vim.api.nvim_set_keymap('n', 'sj', ':call VSCodeNotify("workbench.action.navigateLeft")<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'sk', ':call VSCodeNotify("workbench.action.navigateDown")<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'sl', ':call VSCodeNotify("workbench.action.navigateUp")<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 's;', ':call VSCodeNotify("workbench.action.navigateRight")<CR>',
      { noremap = true, silent = true })

    -- 패널 창 호출
    -- side pannel
    vim.api.nvim_set_keymap('n', 'sp', ':call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>',
      { noremap = true, silent = true })
    -- explorer
    vim.api.nvim_set_keymap('n', 'se', ':call VSCodeNotify("workbench.view.explorer")<CR>', { noremap = true, silent = true })
    -- project manager
    vim.api.nvim_set_keymap('n', 'sm', ':call VSCodeNotify("workbench.view.extension.project-manager")<CR>',
      { noremap = true, silent = true })

    -- 창 크기 조절
    vim.keymap.set('n', 's=', ':call VSCodeNotify("workbench.action.increaseViewSize")<CR>')
    vim.keymap.set('n', 's-', ':call VSCodeNotify("workbench.action.decreaseViewSize")<CR>')

    -- 에디터 좌우로 이동
    vim.keymap.set('n', 'sy', ':call VSCodeNotify("workbench.action.moveEditorToLeftGroup")<CR>')
    vim.keymap.set('n', 'su', ':call VSCodeNotify("workbench.action.moveEditorToRightGroup")<CR>')

    -- zen mode
    vim.api.nvim_set_keymap('n', 'sz', ':call VSCodeNotify("workbench.action.toggleZenMode")<CR>',
      { noremap = true, silent = true })

    -- boolean toggle
    vim.api.nvim_set_keymap('n', 'sb', ':call VSCodeNotify("extension.toggleBool")<CR>', { noremap = true, silent = true })

    -- console
    vim.api.nvim_set_keymap('n', 'mtl', ':call VSCodeNotify("turboConsoleLog.displayLogMessage")<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'mtd', ':call VSCodeNotify("turboConsoleLog.deleteAllLogMessages")<CR>',
      { noremap = true, silent = true })
      

end

-- ---------------------------------------------------------------------------------------------------------
-- 매크로
-- k0f=^[;vt;u
-- 라는 macro 가 a에 저장돼 있을 때,
-- reg a하면 내용을 볼 수 있고,
-- 직접수정하고 싶다면 수정하고 난 다음 블록 지정을 하고
-- 반드시 "" 쌍따옴표 안에 넣는다
-- :let @a="{내용}"
-- ex) :let @a = "k/:\rdf.viwxi#{}\ejp"

-- "au
-- "a 레지스터에 u 복사한다 는 의미
-- "by(나는 "bu): b 레지스터에 복사한다는 의미
-- "bp : b 레지스터 내용 붙여넣기

-- : 를 찾아서 앞에 변수 삭제하고 쿼리용으로 변경
-- "a   kf:^Mdf.viwxi#{}^[jp
-- 밑으로 한줄 내려서 , 콤마 뒤에 쿼리용으로 변경
-- "a   k<80>kh/,^M;;viwxi#{}^[jp

-- ---------------------------------------------------------------------------------------------------------
-- 간단 매크로 <- 이게 제대로 작동됨 250226
-- 현재 글자 복사해서 오른쪽 화면에서 찾기
-- vim.api.nvim_set_keymap('n', '<leader>mf', ":normal uiws;  /<c-r>0<CR>", { noremap = false, silent = true })

vim.keymap.set('n', '<leader>mf', function()
  vim.cmd('normal ujs;')  -- 단어 복사 후 옆 창으로 이동
  vim.defer_fn(function()
    vim.api.nvim_feedkeys("/", "n", false)  -- / 검색창 띄우기

    vim.defer_fn(function()
      vim.api.nvim_feedkeys(vim.fn.getreg("0") .. "\n", "n", false)  -- 복사한 단어 붙여넣고 Enter 입력
    end, 100)  -- 100ms 대기 후 실행 (안정적인 붙여넣기)
  end, 100)  -- 100ms 대기 후 실행 (창 이동 후 / 입력 안정화)
end, { noremap = true, silent = true })

vim.keymap.set('n', 'mt', function()
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
  end

  -- 1. `/` 입력 (검색 모드)
  feedkeys("viw")

  -- 2. VSCode 명령 실행
  vim.fn.VSCodeNotify('extension.changeCamelCase')

end, { silent = true })


vim.keymap.set('n', '<leader>mfj', function()
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
  end

  -- 1. `/` 입력 (검색 모드)
  feedkeys("/")

  -- 2. `:^M` 입력 (검색할 패턴 입력 후 엔터)
  feedkeys(":")
  feedkeys(vim.api.nvim_replace_termcodes("<C-M>", true, false, true))

  -- 3. `df.` ('.'까지 삭제)
  feedkeys("df.")

  -- 4. `viwxa#` (단어 선택 후 # 입력)
  feedkeys("viwx<C-M>a#")

  -- vim.wait(550)  -- 0.1초 대기

  -- 5. `{`을 강제로 입력 (자동 들여쓰기 영향 없음)
  vim.schedule(function()
    vim.api.nvim_put({"{"}, "c", true, true)
  -- 5. `<Esc>` 입력
  feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true))

  vim.schedule(function()
    -- 6. `pa}` (붙여넣기 후 `}` 추가)
    feedkeys("pa}")

    -- 7. `<Esc>` 입력 (명령 모드로 돌아가기)
    feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
    
  end)

  end)

end, { silent = true })

vim.keymap.set('n', '<leader>a', function()
  -- 1.
  -- vim.cmd('normal ujs;')
  -- vim.wait(100)  -- 0.1초 대기
  vim.cmd('normal! /:^Mdf.viwxa#{^[pa}^[^[')
  -- vim.cmd('normal <C-R>*<CR>')
  local success, _ = pcall(function() -- pcall(protected call) return 함수 실행 성공 여부(boolean), 함수의 반환값 또는 오류메시지
    -- 2. tab 키 개행으로 변경
    -- vim.cmd(':%s/	/\\r/g')
    -- 3. 개행을 tab 키로 변경
    -- vim.cmd(':%s/\\n/\\t/g')
    -- 4. : 를 찾고 첫경자 소문자로 변경 후 #{param} 안에 넣기
    -- ~ 가 소문자로 변경
    -- vim.cmd('/:^Mx~viwxi#{^[pa}^[')
    -- 4. test
    -- vim.cmd('echom "echo called"')
    -- :변수 sql 용으로 변경
    -- /:^Mxviwuviwxi#{}^[jp
  end)
  print('Macro \'a\' is called')

  if not success then
    print("pattern not found")
  else
    print("macro excuted")
  end
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>mb', function()
  -- 패턴 검색
  local search_result = vim.fn.search("<ws:deviceTokenCookie>.*</ws:deviceTokenCookie>", "w")

  -- 검색 결과가 있으면 텍스트를 추출
  if search_result ~= 0 then
    -- 현재 줄의 텍스트 가져오기
    local line = vim.fn.getline('.')

    -- 정규표현식을 사용해 태그 안의 값 추출
    local value = line:match("<ws:deviceTokenCookie>(.-)</ws:deviceTokenCookie>")

    -- 추출한 값을 출력
    if value then
      vim.fn.setreg('+', value) -- 시스템 클립보드 레지스터에 저장
      print("Extracted value: " .. value)
    else
      print("Pattern found, but no value extracted")
    end
  else
    print("No match found for the pattern")
  end
end, { noremap = true, silent = true })

-- 비주얼 모드로 전환 후 복사
-- vim.cmd("normal! v")
-- vim.cmd("normal! '+y")

-- 복사한 값 출력
-- local copied_value = vim.fn.getreg('+')
-- print("Copied value: " .. copied_value)


-- ---------------------------------------------------------------------------------------------------------
-- vim-repeat sample
-- vim-repeat과 호환되도록 사용자 정의 명령 설정
local function my_custom_command2()
  -- 현재 줄을 대문자로 변환
  -- vim.cmd('%s/\\(\\w\\)\\n/\\1, /g')
  -- vim.cmd('%s/\\n/ /g')

  vim.api.nvim_command('%s/\\(\\w\\)\\n/\\1, /g | %s/\\n//g')

  -- vim-repeat과 호환되도록 repeat#set 호출 (Vimscript 형식)
  vim.cmd([[silent! call repeat#set("\<Cmd>MyCommand2\<CR>")]])

  print("test3")
end

-- 사용자 정의 명령 생성
vim.api.nvim_create_user_command('MyCommand2', my_custom_command2, {})

-- 키 매핑 설정: <leader>c 키를 눌러 MyCommand2 실행
vim.keymap.set('n', '<leader>m2', ':MyCommand2<CR>', { noremap = true, silent = true })

-- ---------------------------------------------------------------------------------------------------------
-- vim-repeat sample
-- vim-repeat과 호환되도록 사용자 정의 명령 설정
local function my_custom_command()
  -- 현재 줄을 대문자로 변환
  vim.cmd('normal! gUw')

  -- vim-repeat과 호환되도록 repeat#set 호출 (Vimscript 형식)
  vim.cmd([[silent! call repeat#set("\<Cmd>MyCommand\<CR>")]])

  print("test1")
end

-- 사용자 정의 명령 생성
vim.api.nvim_create_user_command('MyCommand', my_custom_command, {})

-- 키 매핑 설정: <leader>c 키를 눌러 MyCommand 실행
vim.keymap.set('n', '<leader>c', ':MyCommand<CR>', { noremap = true, silent = true })

-- ---------------------------------------------------------------------------------------------------------
-- sd 매핑
-- 반페이지 page 이동
-- vim.keymap.set({'n', 'v'}, 'se', '<c-u>') -- up
-- vim.keymap.set({'n', 'v'}, 'sd', '<c-d>') -- down
-- vim-repeat과 호환되도록 사용자 정의 명령 설정
local function sd_command()
  -- 현재 줄을 대문자로 변환
  vim.cmd('normal! <c-d>')

  -- vim-repeat과 호환되도록 repeat#set 호출 (Vimscript 형식)
  vim.cmd([[silent! call repeat#set("\<Cmd>SdCommand\<CR>")]])
end

-- 사용자 정의 명령 생성
-- vim.api.nvim_create_user_command('SdCommand', sd_command, {})

-- 키 매핑 설정: <leader>c 키를 눌러 SdCommand 실행
-- vim.keymap.set('n', 'sd', ':SdCommand<CR>', { noremap = true, silent = true })

-- ---------------------------------------------------------------------------------------------------------
-- 이거 일단 좀 먹힘
-- vim.keymap.set('n', 'sd', '<Cmd>normal! <C-d><CR>', { noremap = true, silent = true })
-- vim.cmd[[silent! call repeat#set("\<Plug>(my-sd)", -1)]]
-- ---------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------
-- nvim-better-n
-- nvim_create_autocmd: Neovim의 Lua API에서 자동 명령(autocommand)을 생성하는 함수입니다. 자동 명령은 특정 이벤트(예: 파일 열기, 저장, 버퍼 이동 등)가 발생할 때 특정 동작을 자동으로 실행하도록 설정할 수 있어, 사용자 작업을 자동화하거나 특정 상황에서 실행되는 스크립트를 작성할 때 유용
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "BetterNMappingExecuted",
--   callback = function(args)
--     -- args.data.key and args.data.mode are available here
--     print(args.data.key .. " is repeated")
--   end
-- })

-- -- You create repeatable mappings like this:
-- local hunk_navigation = require("better-n").create(
--   {
--     hlfPgUp = function()
--       vim.cmd("normal! <c-e>")
--     end,
--     hlfPgDown = function()
--       vim.cm("normal! <c-d<")
--     end
--   }
-- )

-- vim.keymap.set({ "n", "v", "x" }, "se", hunk_navigation.hlfPgUp)
-- vim.keymap.set({ "n", "v", "x" }, "sd", hunk_navigation.hlfPgDown)

-- ---------------------------------------------------------------------------------------------------------
-- leap plugin set
vim.keymap.set({ 'n', 'v' }, 'ff', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'v' }, 'FF', '<Plug>(leap-backward)')
vim.keymap.set({ 'n', 'v' }, 'gf', '<Plug>(leap-from-window)')

-- ---------------------------------------------------------------------------------------------------------
-- leap to line 추가
local function leap_to_line()
  local winid = vim.api.nvim_get_current_win()
  require('leap').leap {
    target_windows = { winid },
    targets = function(opts)
      local targets = {}
      local wininfo = vim.fn.getwininfo(winid)[1]
      local cur_line = vim.fn.line('.')

      for line = wininfo.topline, wininfo.botline do
        if line ~= cur_line then
          table.insert(targets, { pos = { line, 1 } })
        end
      end

      return targets
    end,
  }
end


vim.keymap.set('', 'gv', leap_to_line, { desc = "Leap to line" })


-- --------------------------------------------------------------------------------------------------------
-- leap leap vertical 추가
local function leap_vertical()
  local winid = vim.api.nvim_get_current_win()
  local cur_line = vim.fn.line('.')
  local cur_col = vim.fn.col('.')

  require('leap').leap {
    target_windows = { winid },
    targets = function(opts)
      local targets = {}
      local wininfo = vim.fn.getwininfo(winid)[1]

      for line = wininfo.topline, wininfo.botline do
        if line ~= cur_line then
          -- 현재 라인의 길이를 확인
          local line_length = vim.fn.strdisplaywidth(vim.fn.getline(line))
          -- 현재 열이 라인 길이보다 길면 라인의 마지막 열을 사용
          local col = math.min(cur_col, line_length)
          table.insert(targets, { pos = { line, col } })
        end
      end

      return targets
    end,
  }
end

-- 키 매핑 예시
vim.keymap.set({ 'n', 'v' }, 'gl', leap_vertical, { desc = "Leap vertical" })


-- ---------------------------------------------------------------------------------------------------------
-- substitue

-- Lua
-- 일반 모드 치환 연산자: 이 설정은 's' 키를 누른 후 모션을 입력하여 해당 텍스트 객체를 현재 레지스터의 내용으로 치환할 수 있게 합니다1. 예를 들어, 'siw'는 현재 단어를, 'sip'는 현재 단락을 치환합니다.
vim.keymap.set('n', 's', require('substitute').operator, { noremap = true })
-- 현재 줄 치환: 'ss'를 입력하면 현재 줄 전체를 레지스터의 내용으로 치환합니다
vim.keymap.set('n', 'ss', require('substitute').line, { noremap = true })
-- 'S'를 누르면 커서 위치부터 줄 끝까지의 텍스트를 레지스터의 내용으로 치환합니다
vim.keymap.set('n', 'S', require('substitute').eol, { noremap = true })
-- 비주얼 모드에서 선택한 텍스트를 's'를 눌러 레지스터의 내용으로 치환합니다
vim.keymap.set('x', 's', require('substitute').visual, { noremap = true })
-- 일반 모드 범위 치환 연산자: <leader>s 다음에 두 개의 모션을 입력하여 범위를 지정하고 텍스트를 치환할 수 있게 합니다. 첫 번째 모션은 치환할 텍스트를 선택하고, 두 번째 모션은 치환을 적용할 범위를 지정합니다
-- vim.keymap.set('n', '<leader>s', require('substitute.range').operator, { noremap = true })
-- 비주얼 모드 범위 치환: 비주얼 모드에서 텍스트를 선택한 후 <leader>s를 누르고 모션을 입력하여 선택한 텍스트를 해당 범위 내에서 치환할 수 있습니다
-- vim.keymap.set('x', '<leader>s', require('substitute.range').visual, { noremap = true })
-- 단어 범위 치환: <leader>ss 다음에 모션을 입력하면 커서 아래의 완전한 단어를 선택하고 지정된 범위 내에서 치환합니다. 이 기능은 complete_word 옵션이 true로 설정되어 있어 단어 경계를 요구합니다
-- vim.keymap.set('n', '<leader>ss', require('substitute.range').word, { noremap = true })

-- ---------------------------------------------------------------------------------------------------------
-- nvim-various-textobjs
-- anyQuote 오퍼레이터 대기 모드와 비주얼 모드에서 'iu'를 inner quote로 매핑
vim.keymap.set({ "o", "x" }, "iu", '<cmd>lua require("various-textobjs").anyQuote("inner")<CR>',
  { noremap = true, silent = true })

-- anyQuote 오퍼레이터 대기 모드와 비주얼 모드에서 'au'를 outer quote로 매핑
vim.keymap.set({ "o", "x" }, "au", '<cmd>lua require("various-textobjs").anyQuote("outer")<CR>',
  { noremap = true, silent = true })
-- ---------------------------------------------------------------------------------------------------------
-- yanky.nvim
vim.keymap.set({ "n", "x" }, "p", '<Plug>(YankyPutAfter)')
vim.keymap.set({ "n", "x" }, "P", '<Plug>(YankyPutBefore)')
vim.keymap.set({ "n", "x" }, "gp", '<Plug>(YankyGPutAfter)')
vim.keymap.set({ "n", "x" }, "gP", '<Plug>(YankyGPutBefore)')

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<leader>p", "<Plug>(YankyNextEntry)")
-- ---------------------------------------------------------------------------------------------------------
local Hydra = require('hydra')

-- 마지막 이동 명령을 저장할 변수
local last_motion = nil

-- local hint = [[
-- _r_: repeat last motion
-- _<Esc>_: exit
-- ]]
--

local my_hydra = Hydra({
  name = 'Repeat Last Motion',
  mode = 'n',
  -- body를 지정하지 않고 여기서는 없음
  heads = {
    {
      'r', function()
      if last_motion then
        vim.cmd('normal ' .. last_motion)
      else
        vim.notify("No last motion recorded", vim.log.levels.WARN)
      end
    end,
      { desc = 'repeat last motion' }
    },
    -- { '<leader><Esc>', nil, { exit = true, desc = 'exit Hydra' } },
    { 'C-q', nil, { exit = true, desc = 'exit Hydra' } },
  }
})

-- <leader>h 키를 Hydra로 진입하는 대신, 진입 전에 원하는 일을 하고 activate()
vim.keymap.set('n', '<leader><leader>', function()
  -- vim.keymap.set('n', '<leader>h', function()
  vim.notify("My custom on_enter logic before hydra")

  local input = vim.fn.input('Enter the motion (e.g., 10j): ')
  if input ~= '' then
    last_motion = input
    vim.cmd('normal ' .. last_motion)
  else
    vim.notify("No motion entered", vim.log.levels.WARN)
    -- 빈 입력이면 Hydra 모드 즉시 종료
    vim.schedule(function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
    end)
  end

  my_hydra:activate() -- Hydra 모드 진입
end)

-- ---------------------------------------------------------------------------------------------------------
  -- todo 비주얼모드 복사도 이동하지 않도록 수정
  -- 복사 후 커서 제자리

  local api = vim.api
  local g = api.nvim_create_augroup('user/keep_yank_position', { clear = true })

  api.nvim_create_autocmd('ModeChanged', {
    pattern = { 'n:no', 'no:n' },
    group = g,
    callback = function(ev)
      if vim.v.operator == 'y' then
        if ev.match == 'n:no' then
          vim.b.user_yank_last_pos = vim.fn.getpos('.')
        else
          if vim.b.user_yank_last_pos then
            vim.fn.setpos('.', vim.b.user_yank_last_pos)
            vim.b.user_yank_last_pos = nil
          end
        end
      end
    end,
  })

-- ---------------------------------------------------------------------------------------------------------

  local M = {}

  local augroup = vim.api.nvim_create_augroup
  local keymap = vim.api.nvim_set_keymap

  M.my_vscode = augroup('MyVSCode', {})

  vim.filetype.add {
    pattern = {
      ['.*%.ipynb.*'] = 'python',
      -- uses lua pattern matching
      -- rathen than naive matching
    },
  }
  
  local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
  end

  local function v_notify(cmd)
    return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
  end
  
  -- leader2
  keymap('n', '<Leader>xr', notify 'references-view.findReferences', { silent = true })  -- language references
  keymap('n', '<Leader>xd', notify 'workbench.actions.view.problems', { silent = true }) -- language diagnostics
  -- keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true )
  keymap('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
  keymap('n', '<Leader>fm', notify 'editor.action.formatDocument', { silent = true })
  keymap('n', '<Leader>ca', notify 'editor.action.refactor', { silent = true })                   -- language code actions

  keymap('n', '<Leader>rg', notify 'workbench.action.findInFiles', { silent = true })             -- use ripgrep to search files
  keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
  keymap('n', '<Leader>th', notify 'workbench.action.toggleAuxiliaryBar', { silent = true })      -- toggle docview (help page)
  keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
  keymap('n', '<Leader>fc', notify 'workbench.action.showCommands', { silent = true })            -- find commands
  keymap('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window
  keymap('n', '<Leader>f' , notify 'workbench.action.quickOpen', { silent = true })               -- find files
-- keymap('n', '<Leader>f', notify 'workbench.view.search', { silent = true })               -- show search

-- ---------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------
-- // NOTE
-- 리더 키가 눌렸을 때 relativenumber 활성화 -> 작동 안 됨
-- vim.keymap.set('n', '<leader>', function()

-- 리더 키의 기본 기능을 유지
-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<leader>', true, false, true), 'n', false)

-- nvim_set_option을 사용하여 relativenumber 활성화
-- vim.api.nvim_set_option('relativenumber', true)

-- vim.opt.relativenumber = true  -- 리더 키를 눌렀을 때 relativenumber 활성화
-- vim.cmd('redraw')              -- 화면 즉시 다시 그리기
-- vim.defer_fn(function()
-- vim.opt.relativenumber = true  -- relativenumber 활성화
-- end, 0)  -- 지연 시간은 밀리초 단위로, 0은 즉시 실행
-- end, { expr = true, noremap = true, silent = true })


-- 매핑된 키 확인
-- :map <leader>w
-- 매핑된 키의 출처 확인
-- :verbsoe map <leader>w
-- 창 이동 관련 <C-w> 키 조합
-- <C-w> h:

-- 왼쪽 창으로 이동합니다.
-- <C-w> j:

-- 아래쪽 창으로 이동합니다.
-- <C-w> k:

-- 위쪽 창으로 이동합니다.
-- <C-w> l:

-- 오른쪽 창으로 이동합니다.
-- 추가적인 창 관리 명령
-- <C-w> w 또는 <C-w> <C-w>:

-- 다음 창으로 순차적으로 이동합니다.
-- <C-w> W:

-- 이전 창으로 순차적으로 이동합니다.
-- <C-w> H:

-- 현재 창을 왼쪽으로 이동시킵니다 (창의 위치 변경).
-- <C-w> J:

-- 현재 창을 아래로 이동시킵니다 (창의 위치 변경).
-- <C-w> K:

-- 현재 창을 위로 이동시킵니다 (창의 위치 변경).
-- <C-w> L:

-- 현재 창을 오른쪽으로 이동시킵니다 (창의 위치 변경).
-- <C-w> q:

-- 현재 창을 닫습니다.
-- <C-w> o:

-- 모든 다른 창을 닫고 현재 창만 남깁니다.
-- <C-w> =:

-- 모든 창의 크기를 동일하게 조정합니다.
-- <C-w> +:

-- 현재 창의 높이를 증가시킵니다.
-- <C-w> -:

-- 현재 창의 높이를 감소시킵니다.
-- <C-w> >:

-- 현재 창의 너비를 증가시킵니다.
-- <C-w> <:

-- 현재 창의 너비를 감소시킵니다.
-- 요약
-- 창 간 이동: <C-w> h, <C-w> j, <C-w> k, **<C-w> l**를 사용하여 좌/우/상/하로 창을 이동할 수 있습니다.
-- 창 위치 변경 및 크기 조정: <C-w> H, <C-w> L, <C-w> +, <C-w> > 등 다양한 명령어를 사용해 창을 조정할 수 있습니다.
-- 이 명령어들을 사용하면 Neovim에서 여러 창을 효율적으로 관리할 수 있습니다.
--
-- ctrl + ] 함수가 정의된 곳으로 이동
-- ctrl + o 원래 위치로 이동
--
-- gd: 정의된 위치로 이동,  GD? 으로 이동
-- g shift h : reference 찾기

-- c-o: 마지막 수정으로 이동
-- c-i: 앞 수정으로 이동

-- -- 기본 키 맵핑
-- keymap.set('n', 'x', '"_x')

-- -- 단어 삭제
-- keymap.set('n', 'dw', 'vb"_d')

-- -- 전체 권한
-- keymap.set('n', '<C-a>', 'gg<S-v>G')

-- -- 새 탭 열기
-- keymap.set('n', 'te', ':tabedit<Return>', { silent = true })

-- -- 창 이동
-- keymap.set('n', '<Space>', '<C-w>w')
-- keymap.set('', 's<left>', '<C-w>h')
-- keymap.set('', 's<up>', '<C-w>k')
-- keymap.set('', 's<down>', '<C-w>j')
-- keymap.set('', 's<right>', '<C-w>l')
-- keymap.set('', 'sh', '<C-w>h')
-- keymap.set('', 'sk', '<C-w>k')
-- keymap.set('', 'sj', '<C-w>j')
-- keymap.set('', 'sl', '<C-w>l')
--

-- shift + k
-- gh
-- hover widget


-- ---------------------------------------------------------------------------------------------------------
-- hop -- leap 로 대체. 미사용
-- local hop = require('hop')
-- local directions = require('hop.hint').HintDirection

-- vim.keymap.set('', 'gl', function()
--   hop.hint_lines()
-- end, {noremap=true})

--[[ vim.keymap.set('', 'gv', function()
  hop.hint_vertical()
end, {noremap=true}) ]]

-- vim.keymap.set('', 'gp', function()
--   hop.hint_patterns()
-- end, {noremap=true})

-- vim.keymap.set('', 'gw', function()
--   hop.hint_words()
-- end, {noremap=true})

-- vim.keymap.set('', 'f', function()
--   hop.hint_char1()
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})
-- ---------------------------------------------------------------------------------------------------------
-- substitute :s 치환 예제
-- :[범위]s/찾을_텍스트/바꿀_텍스트/[옵션]
-- g	모든 일치 항목을 변경 (기본적으로 한 줄에 첫 번째 항목만 변경됨)
-- c	치환하기 전에 확인 (yes/no)
-- i	대소문자 무시 (ignorecase)
-- I	대소문자 구별 (noignorecase)

-- 1. , -> 개행으로 변경 \r 을 개행으로 인식함
-- %s/,/\r/g

-- 2. \d: 숫자, \w: 모든 문자
-- | 는 or 조건으로 사용한다
-- %s\M\(\d\)/L\1/g
-- -> sql에 사용, M"숫자" -> L"숫자" 로 변경 \d: 숫자, \(\): 캡쳐, \1: 첫번째 캡쳐

-- 3. %s/\([a-zA-Z0-9]\)\n/\1, /g
-- -> '문자열\n' -> '문자열, ' 로 변경

-- 4. %s/\(\w\)\n/\1, /g
-- w로 사용한 버전
-- %s/\(\w\)\n/\1, /g | %s/\n//g
-- 두개의 치환을 동시에 사용할 수 있음
-- 앞에 문자열이 있고 개행문자가 있는 경우는 ', ' 로 개행문자만 있는 경우는 ''로 치환

-- 5. %s/	/\r/g
-- 엑셀 tab으로 구분돼있는 컬럼을 pivot 하기 위함




-- ---------------------------------------------------------------------------------------------------------
