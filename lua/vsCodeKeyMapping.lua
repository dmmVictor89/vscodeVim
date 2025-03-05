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
