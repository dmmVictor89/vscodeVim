" 리더 키 설정
let mapleader=" "

" :set virtualedit=onemore

" 시스템 클립보드 사용
set clipboard=unnamedplus
set clipboard=unnamed

" 대소문자 무시 검색 설정
set ignorecase
set smartcase

" kk를 esc 로 설정  
inoremap kk <ESC>


nnoremap j h
vnoremap j h
nnoremap k j
vnoremap k j
nnoremap l k
vnoremap l k
nnoremap ; l 
vnoremap ; l 
nnoremap h ; 
vnoremap h ; 

" shift+a 를 shift+v(한줄 선택으로 변경)
nnoremap vv V 
vnoremap v V

" j key binding 없애기 normal 모드, visual 모드
nnoremap J <Nop> 
vnoremap J <Nop> 

" y -> u set yank
nnoremap y u 
vnoremap y u 
" yu로 yiw 날리기
nnoremap ui yiw 
" u -> y set undo
nnoremap u y 
" vnoremap u ygv 
vnoremap u y`> 
nnoremap uu yy 
vnoremap uu yy 

nnoremap p "0p
vnoremap p "0p

nnoremap P "0P
vnoremap P "0P

" <leader>u 를 'I'로 매핑 (줄의 시작으로 이동하여 입력 모드)

nmap <leader>u I
vmap <leader>u I

" <leader>i 를 'A'로 매핑 (줄의 끝으로 이동하여 입력 모드)
nmap <leader>i A
vmap <leader>i A

" <leader>a 를 'A'로 매핑
nmap <leader>a A
vmap <leader>a A

" '-' 키를 '$'로 매핑 (줄의 끝으로 이동)
nmap - $
vmap - $

" 아래에 새로운 행 생성
nmap o $a<CR>

" 아래에 새로운 행을 만들고 노멀 모드로 전환
" nmap <leader>o o<Esc>0"_D

" <leader>j 를 줄 연결 명령어로 매핑
" nmap <leader>j J

" 'uj'를 'yiw'로 매핑 (단어 복사)
noremap uj yiw
vnoremap uj yiw

" 'Y' 키를 'Ctrl + r'로 매핑 (Redo)
noremap Y <C-r>


" 'st'를 검색 하이라이트 끄기로 매핑
noremap st :noh<CR>


" 창 분할 매핑
noremap sg :split<CR>
noremap sv :vsplit<CR>

" 삭제 시 클립보드에 영향을 주지 않도록 설정
" noremap d \"_d
" vnoremap d \"_d
" noremap D \"_D
" vnoremap D "_D

" <leader>v 를 비주얼 블록 모드로 매핑
noremap <leader>v <C-v>
vnoremap <leader>v <C-v>

" 작은따옴표와 백틱 키 교환
noremap ' `
vnoremap ' `

" <leader>x 키로 창 닫기 기능을 매핑
nmap <leader>x :q<CR>

" 창 이동
nnoremap sj <C-w>h
nnoremap sk <C-w>j
nnoremap sk <C-w>k
nnoremap s; <C-w>l

" ge 로 = '' 입력하기
noremap ge a = ''<ESC>i
" gi 로 in ('', '') 입력하기
noremap gi a in ('', '')<ESC>hhhhhi