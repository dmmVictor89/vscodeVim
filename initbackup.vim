echo "vim on"
" init.vim 예제: clipboard 설정
set clipboard=unnamedplus

" 대소문자를 구분하지 않는 검색을 설정
set ignorecase
" 검색어에 대문자가 포함되어 있으면 대소문자를 구분하여 검색
set smartcase

" Leader 키를 스페이스로 설정
let mapleader = " "

" <Leader>w를 눌렀을 때 <C-w>w 실행
nnoremap <leader>w <C-w>w

" 삭제 관련 설정
" nnoremap <leader>d "+d     " 리더 키와 함께 'd'를 누르면 클립보드에 저장
" 그냥 'd'를 누르면 클립보드에 저장하지 않음 (normal mode)
 nnoremap d "_d
 " 그냥 'd'를 누르면 클립보드에 저장하지 않음 (visual mode)
 vnoremap d "_d

set number

" 숫자를 누르면 relativenumber로 전환하고, 이동 후 다시 절대 번호로 설정하는 설정
augroup numbertoggle
  autocmd!
" 이동이 완료되면 다시 absolute number로 변경
  autocmd CursorMoved,CursorMovedI * set norelativenumber | echo "test3"
augroup END

" 커서 이동 또는 다른 동작을 수행하는 함수 정의
function! MyFunctionForNumber(num)
    echo "function called"
    call timer_start(0, {-> execute('set relativenumber')})
"    call feedkeys(a:num, 'n')
    return a:num    
endfunction

" 노멀 모드에서 숫자 1-9가 입력된 경우 특정 동작을 수행하도록 매핑
nnoremap 1 :call MyFunctionForNumber(1)<CR>
nnoremap 2 :call MyFunctionForNumber(2)<CR>
nnoremap 3 :call MyFunctionForNumber(3)<CR>
nnoremap 4 :call MyFunctionForNumber(4)<CR>
nnoremap 5 :call MyFunctionForNumber(5)<CR>
nnoremap 6 :call MyFunctionForNumber(6)<CR>
nnoremap 7 :call MyFunctionForNumber(7)<CR>
nnoremap 8 :call MyFunctionForNumber(8)<CR>
nnoremap 9 :call MyFunctionForNumber(9)<CR>