"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_contrast_dark = 'hard'
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = ''
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" : "\<TAB>"

let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified' ] ]
  \ ,
  \   'right': [ [ 'lineinfo' ],
  \              ['linter_checking', 'linter_errors',
  \               'linter_warnings', 'linter_infos', 'linter_ok' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \ },
  \ 'component_expand': {
  \  'linter_checking': 'lightline#ale#checking',
  \  'linter_infos': 'lightline#ale#infos',
  \  'linter_warnings': 'lightline#ale#warnings',
  \  'linter_errors': 'lightline#ale#errors',
  \  'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \     'linter_checking': 'right',
  \     'linter_infos': 'right',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'right',
  \ }
\ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline.separator = {
  \   'left': '', 'right': ''
\}
let g:lightline.subseparator = {
  \   'left': '', 'right': ''
\}
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

let g:fzf_layout = { 'down': '~10%' }

let g:rainbow_active = 1

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'morhetz/gruvbox'
  Plug 'yggdroot/indentline'
  Plug 'luochen1990/rainbow'
  Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdcommenter'
  Plug 'easymotion/vim-easymotion'
  Plug 'dense-analysis/ale'
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'stephpy/vim-php-cs-fixer'
  Plug 'StanAngeloff/php.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set history=500
filetype plugin on
filetype plugin indent on
set autoread
set laststatus=2
set noshowmode
set textwidth=80
set formatoptions+=t
au FocusGained,BufEnter * checktime

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=18
set number relativenumber
set wildmenu
set ruler
set cmdheight=1
set hid
set backspace=eol,start,indent
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme gruvbox
set encoding=utf8
set ffs=unix,dos,mac
highlight Normal ctermbg=none
highlight NonText ctermbg=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set lbr
set tw=500
set ai
set si
set wrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <SPACE> <Nop>
noremap <Up>    :10winc -<CR>
noremap <Down>  :10winc +<CR>
noremap <Left>  :10winc <<CR>
noremap <Right> :10winc ><CR>

let mapleader = " "

nmap <leader><CR>       :FZF<CR>
nmap <leader><leader>   :w!<CR>
nmap <leader><F11>      <Plug>(ale_previous_wrap)
nmap <leader><F23>      <Plug>(ale_next_wrap)
nmap <leader><F12>      :ALEGoToDefinition<CR>
nmap <leader><F24>      :ALEFindReferences<CR>
nmap s                  <Plug>(easymotion-overwin-f2)

omap /                  <Plug>(easymotion-tn)

map <leader>s     :Ag<space>
map <leader><ESC> :noh<CR>
map <Leader>      <Plug>(easymotion-prefix)
map  /            <Plug>(easymotion-sn)
map  n            <Plug>(easymotion-next)
map  N            <Plug>(easymotion-prev)

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
      if !isdirectory(dir)
        call mkdir(dir, 'p')
      endif
  endif
endfunction

augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


highlight OverLength guibg=#f4c2c2
match OverLength /\%100v.\+/
