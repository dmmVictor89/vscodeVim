--------------------------------------------------
-- Improved Neovim KeyMapping Configuration
-- 개선 사항:
-- 1. 중첩 defer_fn 호출 최적화
-- 2. VSCode 통신 디바운싱 적용
-- 3. API 통일 및 불필요한 주석 제거 (주석은 그대로 유지)
-- 4. Autocmd 최적화
--------------------------------------------------

-- print("vim on (Improved version)")


-- 기존 print를 vim.notify로 변경 (중간 로그)
vim.notify("vim on (Improved version)", vim.log.levels.INFO)

-- todo //test
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
-- 기존 :nmap -> lua style 매핑
vim.keymap.set('n', '<leader>cf', ':e C:\\Users\\이진표\\AppData\\Local\\nvim\\init.lua', { noremap = true })

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
vim.keymap.set('n', '<leader>o', 'o<Esc>0"_D', { noremap = true, silent = true })

-- join lines
vim.keymap.set('n', '<leader>j', 'J', { noremap = true, silent = true })
-- ---------------------------------------------------------------------------------------------------------
-- motion keys (left, down, up, left)
vim.keymap.set({ 'n', 'v' }, 'j', 'h')
vim.keymap.set({ 'n', 'v' }, 'k', 'j')
vim.keymap.set({ 'n', 'v' }, 'l', 'k')
vim.keymap.set({ 'n', 'v' }, ';', 'l')
vim.keymap.set({ 'n', 'v' }, 'h', ';')
-- vim.keymap.set({'n', 'v'}, 'h', '\'')

vim.keymap.set({ 'n', 'v' }, 'H', 'b')
vim.keymap.set({ 'n', 'v' }, 'L', 'w')

-- y -> u set yank
vim.keymap.set({ 'n', 'v' }, 'y', 'u')
-- u -> y set undo
-- vim.keymap.set({'n', 'v'}, 'u', 'y')
-- vim.keymap.set({'n', 'v'}, 'uu', 'yy')

-- yu로 yiw 날리기
vim.keymap.set({ 'n', 'v' }, 'uj', 'yiw')

vim.keymap.set({ 'n', 'x' }, 'u', '<Plug>(YankyYank)', { noremap = true })
vim.keymap.set('n', 'uu', 'V<Plug>(YankyYank)', { noremap = true })

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
vim.keymap.set('n', 'st', ':noh<CR>', { noremap = true, silent = true })

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

-- vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, 'x', 'x')

-- Delete to the end
vim.keymap.set({ 'n', 'v' }, 'D', '"_D')




-- Ctrl+e 가 diw 로 동작
vim.keymap.set('v', '<c-e>', '"_diw')

-- multiple line mode
vim.keymap.set({ 'n', 'v' }, '<leader>v', '<c-v>')

-- ---------------------------------------------------------------------------------------------------------
-- 블록 이동 변경
vim.keymap.set({ 'n', 'v' }, ']]', ']}')
vim.keymap.set({ 'n', 'v' }, '[[', '[{')

vim.keymap.set({ 'n', 'v' }, ']}', ']]')
vim.keymap.set({ 'n', 'v' }, '[{', '[[')

-- ---------------------------------------------------------------------------------------------------------
-- set line number
-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true

-- `(백틱)으로 상대번호, 절대번호 모드 변경하기
vim.keymap.set({ 'n', 'v' }, '`', function()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
  else
    vim.opt.relativenumber = true
  end
end)

-- 처음에 상대 번호를 안 쓰기 위해서 설정하려고 했던건데 비효율적
-- -- Create an auto group for toggling relative and absolute numbers
-- local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- -- Switch to absolute number after cursor movement
-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--   group = numbertoggle,
--   callback = function()
--     vim.opt.relativenumber = true
--   end,
-- })

-- -- Map <leader> to also toggle relativenumber while preserving its functionality
-- vim.keymap.set({ 'n', 'v' }, '`', function()
--   vim.opt.relativenumber = false -- ` 키를 눌렀을 때 relativenumber 활성화
--   -- vim.cmd('redraw')           -- 화면 즉시 다시 그리기
--   -- return '<leader>'           -- 리더 키의 원래 기능 유지
-- end, { expr = true })

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
  vim.notify("vscode setting is loaded", vim.log.levels.INFO) 
  
  local vscode = require('vscode')
  
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

    -- o 설정
    vim.keymap.set('n', 'o', function()
        vim.fn.VSCodeNotify('editor.action.insertLineAfter')
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('A', true, false, true), 'n', false)
    end, { noremap = true, silent = true, desc = "Insert line after with VS Code indent" })

    --  fixed cursor scroll
    vim.keymap.set({ 'n', 'v' }, 'J', function()
        for _ = 1, 10 do
            vim.fn.VSCodeNotify('vscode-neovim.ctrl-e') -- fixed cursor & scroll down
        end
    end, { noremap = true, desc = "Scroll down 10 lines" })

    vim.keymap.set({ 'n', 'v' }, 'K', function()
        for _ = 1, 10 do
            vim.fn.VSCodeNotify('vscode-neovim.ctrl-y') -- fixed cursor & scroll up
        end
    end)

    vim.keymap.set('n', '0', function()
      vim.fn.VSCodeNotify("cursorHome")
    end, { noremap = true, silent = true })

    -- close window
    vim.keymap.set('n', '<leader>x', function()
      local win_count = #vim.api.nvim_list_wins()                   -- 현재 열린 창의 개수
      if win_count > 1 then
        vim.fn.VSCodeNotify('workbench.action.closeActiveEditor')   -- VSCode의 창 닫기 명령 호출
      end
    end, { noremap = true, silent = true })

    -- multi cursor
    vim.keymap.set({ "n", "x", "i" }, "<C-i>", function()
      vscode.with_insert(function()
        vscode.action("editor.action.addSelectionToNextFindMatch")
      end)
    end)

    -- file open
    vim.keymap.set({ "n", "x", "i" }, "fo", function()
      vscode.with_insert(function()
        vscode.action("workbench.action.files.openFile")
      end)
    end)
    
    -- folder open
    vim.keymap.set({ "n", "x", "i" }, "fd", function()
      vscode.with_insert(function()
        vscode.action("workbench.action.files.openFile")
      end)
    end)
    

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
    vim.keymap.set('n', 'gt', function() vim.fn.VSCodeNotify("workbench.action.nextEditor") end, { noremap = true, silent = true, nowait = true })
    vim.keymap.set('n', 'gr', function() vim.fn.VSCodeNotify("workbench.action.previousEditor") end, { noremap = true, silent = true, nowait = true })

    -- 윈도우 관련
    vim.keymap.set('n', 'sj', function() vim.fn.VSCodeNotify("workbench.action.navigateLeft") end, { noremap = true, silent = true })
    vim.keymap.set('n', 'sk', function() vim.fn.VSCodeNotify("workbench.action.navigateDown") end, { noremap = true, silent = true })
    vim.keymap.set('n', 'sl', function() vim.fn.VSCodeNotify("workbench.action.navigateUp") end, { noremap = true, silent = true })
    vim.keymap.set('n', 's;', function() vim.fn.VSCodeNotify("workbench.action.navigateRight") end, { noremap = true, silent = true })

    -- Peek Definition(정의 미리보기 (alt+F12)
    vim.keymap.set('n', 'sh', function() vim.fn.VSCodeNotify("editor.action.peekDefinition") end, { noremap = true, silent = true })

    -- 패널 창 호출
    vim.keymap.set('n', 'sp', function() vim.fn.VSCodeNotify("workbench.action.toggleSidebarVisibility") end, { noremap = true, silent = true })
    -- explorer
    vim.keymap.set('n', 'se', function() vim.fn.VSCodeNotify("workbench.view.explorer") end, { noremap = true, silent = true })
    -- project manager
    vim.keymap.set('n', 'sm', function() vim.fn.VSCodeNotify("workbench.view.extension.project-manager") end, { noremap = true, silent = true })

    -- 창 크기 조절
    vim.keymap.set('n', 's=', function() vim.fn.VSCodeNotify("workbench.action.increaseViewSize") end)
    vim.keymap.set('n', 's-', function() vim.fn.VSCodeNotify("workbench.action.decreaseViewSize") end)

    -- 에디터 좌우로 이동
    vim.keymap.set('n', 'sy', function() vim.fn.VSCodeNotify("workbench.action.moveEditorToLeftGroup") end)
    vim.keymap.set('n', 'su', function() vim.fn.VSCodeNotify("workbench.action.moveEditorToRightGroup") end)

    -- zen mode
    vim.keymap.set('n', 'sz', function() vim.fn.VSCodeNotify("workbench.action.toggleZenMode") end, { noremap = true, silent = true })

    -- boolean toggle
    vim.keymap.set('n', 'sb', function() vim.fn.VSCodeNotify("extension.toggleBool") end, { noremap = true, silent = true })

    -- console
    vim.keymap.set('n', 'mtl', function() vim.fn.VSCodeNotify("turboConsoleLog.displayLogMessage") end, { noremap = true, silent = true })
    vim.keymap.set('n', 'mtd', function() vim.fn.VSCodeNotify("turboConsoleLog.deleteAllLogMessages") end, { noremap = true, silent = true })

  -- noevim native 에서 사용할 것
  else
    
    -- 윈도우 관련
    vim.keymap.set('n', 'sj', '<C-w>h', { noremap = true, silent = true })
    vim.keymap.set('n', 'sk', '<C-w>j', { noremap = true, silent = true })
    vim.keymap.set('n', 'sl', '<C-w>k', { noremap = true, silent = true })
    vim.keymap.set('n', 's;', '<C-w>l', { noremap = true, silent = true })
    
    -- 창 크기 조절
    vim.keymap.set('n', 's=', ':vertical resize +10<CR>')
    vim.keymap.set('n', 's-', ':vertical resize -10<CR>')
    vim.keymap.set('n', 's9', ':resize +10<CR>')
    vim.keymap.set('n', 's0', ':resize -10<CR>')

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
-- 먼저, vim.api.nvim_replace_termcodes는 입력 문자열(예: ciw''<Esc>j"ap)을 Neovim이 이해할 수 있는 실제 키 코드로 변환하는 함수입니다. 이 함수는 feedkeys에 전달할 키 시퀀스를 준비합니다.
-- 파라미터 설명
-- 1. str (string):
-- 변환할 입력 문자열. 여기서는 keys로 전달된 문자열(예: ciw''<Esc>j"ap).
-- 2. replace_keycodes (boolean):
-- 특수 키(예: <Esc>, <CR>, <Space>)를 실제 키 코드로 변환할지 여부.
-- 3. replace_single_key (boolean):
-- 단일 키(예: <, >, |)를 특수 키로 처리할지 여부.
-- false (당신의 코드): 단일 키를 문자 그대로 처리합니다. 예: <는 < 문자로 남고, <Esc> 같은 특수 키만 변환됩니다.
-- true: <나 > 같은문자도 특수 키로 간주하려고 시도합니다(보통 필요하지 않음).
-- 4. special (boolean):
-- 특수 문자를 추가로 이스케이프 처리할지 여부(예: <를 \<로 변환).
-- true (당신의 코드): 특수 문자를 Neovim의 내부 표현으로 변환하여 feedkeys가 정확히 처리할 수 있도록 합니다.
-- false: 특수 문자를 이스케이프하지 않고 그대로 전달.

-- vim.api.nvim_feedkeys 파라미터
-- keys (string): 실행할 키 입력 시퀀스. 여기서는 vim.api.nvim_replace_termcodes(keys, true, false, true)의 출력이 전달됩니다.
-- mode (string):
-- 키 입력을 처리할 모드. 이 파라미터는 feedkeys가 입력을 어떻게 해석하고 실행할지를 결정합니다.
-- 당신의 코드에서는 'm'을 사용했으며, 가능한 값은 다음과 같습니다:
-- 'm' (remap, 당신의 코드):
-- 입력된 키를 리매핑을 적용하여 처리합니다.
-- 예: 당신의 리매핑에서 j는 h(왼쪽 이동)로 매핑되어 있으므로, j를 feedkeys에 넣으면 h 동작(왼쪽 이동)이 실행됩니다.
-- 리매핑된 키(예: j → h)를 사용하려는 경우 적합.
-- 'n' (no remap):
-- 리매핑을 무시하고 키를 원래 Vim/Neovim 명령으로 처리합니다.
-- 예: j는 아래로 이동, h는 왼쪽으로 이동.
-- 이전 코드에서 h가 작동했던 이유는 'n' 모드에서 h를 원래 의미(왼쪽 이동)로 실행했기 때문입니다.
-- 't' (terminal):
-- 터미널 모드에서 키를 처리. 일반적으로 터미널 입력에 사용.
-- 'x' (execute):
-- 입력을 바로 실행(리매핑 무시, 즉시 처리).

-- ---------------------------------------------------------------------------------------------------------
-- 단어를  큰 따옴표 안에 넣기
vim.keymap.set('n', "m\"", function()
    
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'm', false)
  end
  feedkeys("\"aciw\"\"<Esc>j\"ap")
  
  end, { silent = true })

-- 단어를 작은 따옴표 안에 넣기
vim.keymap.set('n', "m'", function()
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'm', false)
  end
  feedkeys("\"aciw''<Esc>j\"ap")
end, { silent = true })

-- 단어를 괄호 안에 넣기
vim.keymap.set('n', "m(", function()
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'm', false)
  end
  feedkeys("\"aciw()<Esc>j\"ap")
end, { silent = true })

-- 단어를 중괄호 안에 넣기
vim.keymap.set('n', "m{", function()
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'm', false)
  end
  feedkeys("\"aciw{}<Esc>j\"ap")
end, { silent = true })

-- 현재 글자 복사해서 현재 위치부터 검색
vim.keymap.set('n', 'mg', function()
  vim.cmd('normal uj') -- 단어 복사 후 최상단으로 이동
  vim.defer_fn(function()
    vim.api.nvim_feedkeys("/" .. vim.fn.getreg("0") .. "\n", "n", false)
  end, 150) -- 150ms 대기
end, { noremap = true, silent = true })

-- 현재 글자 복사해서 현재 위치부터 뒤로 검색
vim.keymap.set('n', 'mw', function()
  vim.cmd('normal uj') -- 단어 복사 후 최상단으로 이동
  vim.defer_fn(function()
    vim.api.nvim_feedkeys("?" .. vim.fn.getreg("0") .. "\n", "n", false)
    -- vim.api.nvim_feedkeys("?" .. vim.fn.getreg("0") .. "\n", false)
  end, 150) -- 150ms 대기
  vim.cmd('normal n') -- 뒤로 한번 이동
end, { noremap = true, silent = true })


-- 현재 글자 복사해서 최상단에서부터 검색
vim.keymap.set('n', 'ms', function()
  vim.cmd('normal ujgg') -- 단어 복사 후 최상단으로 이동
  vim.defer_fn(function()
    vim.api.nvim_feedkeys("/" .. vim.fn.getreg("0") .. "\n", "n", false)
  end, 150) -- 150ms 대기
end, { noremap = true, silent = true })

-- 현재 글자 복사해서 오른쪽 화면에서 찾기
vim.keymap.set('n', 'mf', function()
  vim.cmd('normal ujs;') -- 단어 복사 후 옆 창으로 이동
  vim.defer_fn(function()
    vim.api.nvim_feedkeys("/" .. vim.fn.getreg("0") .. "\n", "n", false)
  end, 150) -- 150ms 대기
end, { noremap = true, silent = true })

-- defer  비효율적인 방식
-- vim.keymap.set('n', '<leader>mf', function()
--   vim.cmd('normal ujs;')  -- 단어 복사 후 옆 창으로 이동
--   vim.defer_fn(function()
--     vim.api.nvim_feedkeys("/", "n", false)  -- / 검색창 띄우기

--     vim.defer_fn(function()
--       vim.api.nvim_feedkeys(vim.fn.getreg("0") .. "\n", "n", false)  -- 복사한 단어 붙여넣고 Enter 입력
--     end, 100)  -- 100ms 대기 후 실행 (안정적인 붙여넣기)
--   end, 100)  -- 100ms 대기 후 실행 (창 이동 후 / 입력 안정화)
-- end, { noremap = true, silent = true })


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
--   end,
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

    targets = function()
      local targets = {}
      local wininfo = vim.fn.getwininfo(winid)[1]
      local cur_line = vim.fn.line('')
      local max_lines = math.min(wininfo.botline - wininfo.topline + 1, 60) -- 최대 50개 라인으로 제한
      for i = 0, max_lines - 1 do
        local line = wininfo.topline + i
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
    { 'C-q', nil, { exit = true, desc = 'exit Hydra' } },
  }
})

-- <leader>h 키를 Hydra로 진입하는 대신, 진입 전에 원하는 일을 하고 activate()
vim.keymap.set('n', '<leader><leader>', function()
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
keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', { silent = true })             -- use ripgrep to search files
keymap('n', '<Leader>th', notify 'workbench.action.toggleAuxiliaryBar', { silent = true })      -- toggle docview (help page)
keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
keymap('n', '<Leader>fc', notify 'workbench.action.showCommands', { silent = true })            -- find commands
keymap('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window
keymap('n', '<Leader>f' , notify 'workbench.action.quickOpen', { silent = true })               -- find files
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

-- 6. \\((\\d+)(?:,\\d+)?\\)
--    	"SEQ" NUMBER(12,0) NOT NULL ENABLE, 
-- 여기서 괄호 안의 숫자만 뽑아내기



-- ---------------------------------------------------------------------------------------------------------
