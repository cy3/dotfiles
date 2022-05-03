filetype off 

set langmenu=en_US.UTF-8
language messages en_US.UTF-8

set rtp+=/usr/local/opt/fzf
call plug#begin('~/.vim/plugged')

"colorscheme
Plug 'junegunn/seoul256.vim'
Plug 'sickill/vim-monokai'
Plug 'AlessandroYorba/Sierra'
Plug 'jacoborus/tender.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'franbach/miramare'
Plug 'sainnhe/sonokai'
Plug 'stillwwater/vim-nebula'
Plug 'morhetz/gruvbox'

"tools
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-tbone'

"code
Plug 'fatih/vim-go'
Plug 'jackguo380/vim-lsp-cxx-highlight'

"tweek
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

"icon
Plug 'ryanoasis/vim-devicons'

"Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do' : { -> mkdp#util#install() } }

call plug#end()

filetype plugin indent on "indent/plugin load by filetype
syntax on
set si "smart indent
set expandtab "tab to space
set ts=2 "tab size
set sw=2 ">> size
set smarttab "delete indent fast
set nu "line number
set wmnu "tab autocomplete
set ignorecase "case insensitive
set smartcase "case sensitive when uppercase include
set nosmartindent " # comment can indent
set showmatch "() highlight
set hlsearch "highlight search
set incsearch "instant search
set fileencodings=utf-8,euc-kr
set ruler "cursor show
set title "show current file in window title
set scrolloff=5 "bottom margin
set linebreak "break line by word
let &showbreak = '+++ ' "break line indicate
set listchars=trail:· "show trail
"set listchars=tab:▸\ ,eol:¬
"set list "tabs display as ^I
let mapleader = " " " map leader to Space
set t_Co=256
set shm+=atI "no wellcome screen, abbr msg
set mouse=a "mouse scroll over vim 
set clipboard=unnamedplus

"colorscheme
set termguicolors
colorscheme sonokai

"map settings
map <F1> :Ag<CR>
"map <F2> :NERDTreeToggle<CR>
"map <F2> :NERDTree<CR>
map <F2> :CocCommand explorer --position floating<CR>
map <F3> :Vista coc<CR>
"map <F4> :CocDisable<CR>
map <F5> :call CocAction('diagnosticToggle')<CR>
"map <F5> :Colors<CR>
noremap <leader>h :noh<CR>
"easy :
nnoremap ; :
" mac copy to clipboard
if has('mac')
  noremap <leader>c :'<,'>w !pbcopy<CR><CR>
  noremap <leader>C :%w !pbcopy<CR><CR>
endif
noremap <leader>n :set invnumber<CR>
noremap <leader>m :MarkdownPreview<CR>
noremap <c-j> <c-d>
noremap <c-k> <c-u>
noremap <c-h> :bp<CR>
noremap <c-l> :bn<CR>
noremap <c-p> :Buffers<CR>
noremap <c-t> :Files<CR>
noremap <c-e> :CocCommand explorer --position floating<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"REPL
let repl = "{bottom}"
"split tmux
noremap <leader>t :Tmux split-window -d -l 5 <CR>

"c++ REPL
augroup cpp_au
  autocmd!
  " c++ build for ps
  if has('mac')
    autocmd FileType cpp let c#compiler = "clang++"
  else
    autocmd FileType cpp let c#compiler = "g++"
  endif
  autocmd FileType cpp let c#psbuild = c#compiler . " -Wall -std=c++11 %:t ; " .
      \ "if [ $? -eq 0 ] ; then " .
      \ "if [ -f \"%:r.txt\" ] ; then cat %:r.txt \| ./a.out; " .
      \ "else ./a.out; fi; fi"
  autocmd FileType cpp noremap <leader>r :w<CR> :execute ":!" . c#psbuild <CR>
  autocmd FileType cpp let c#psrun = " ./vim_run.sh SPACE " .
        \ expand("%:t") . " SPACE " . expand("%:r") . " ENTER"
  autocmd FileType cpp noremap <leader>s :w<CR>
        \ :execute ":Tmux send-keys -t " . repl . c#psrun <CR>
augroup END

"python REPL
augroup python_au
  autocmd!
  "split repl
  autocmd FileType python
        \ noremap <leader>i :Tmux split-window -d -l 7 'ipython3 --no-autoindent' <CR>
  "send line
  autocmd FileType python 
        \ noremap <leader>l :execute ".Twrite " . repl<CR>
  "send line and jump to shell
  autocmd FileType python 
        \ nmap <leader>L <leader>l :execute "Tmux select-pane -t " . repl<CR> 
  "send by clipboard
  autocmd FileType python 
        \ noremap <leader>s :execute "Tmux send-keys -t " . repl . " %paste SPACE -q ENTER"<CR>
  if has('mac')
    autocmd FileType python vmap <leader>r :w !pbcopy<CR><CR> <leader>s
  else
    autocmd FileType python vmap <leader>r :yank<CR> <leader>s
  endif
  "send block (# =)
  autocmd FileType python nmap <leader>v ?# =<CR>v/# =<CR><leader>r
  "send block (enter sperated)
  autocmd FileType python nmap <leader>d {v}<leader>r
  "send function
  autocmd FileType python nmap <leader>f ]d<leader>r
  "send class
  autocmd FileType python nmap <leader>c ]c<leader>r
  "send buffer
  autocmd FileType python nmap <leader>b ggVG<leader>r 
augroup END

"coc settings
set pumheight=20  "autocomplete window len
inoremap <nowait><expr> <C-h> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
inoremap <nowait><expr> <C-j> pumvisible() ? "\<c-n>" : "\<Down>"
inoremap <nowait><expr> <C-k> pumvisible() ? "\<c-p>" : "\<Up>"
inoremap <nowait><expr> <C-l> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Ag when coc not available
function! MyGoDef()
  if !CocAction('jumpDefinition')
    exe ':Ag' expand('<cword>')
  endif
endfunction

"nmap <c-]> <Plug>(coc-definition)
noremap <c-]> :call MyGoDef()<CR>

"go settings
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled=0

"goyo
map <c-w><c-o> :Goyo<CR>
map <c-w>o :Goyo<CR>
let g:goyo_width = 80
let g:goyo_height = 100

"COC-explorer
autocmd VimEnter * if !argc() | execute 'CocCommand explorer --position floating' | endif

""airline settings
set laststatus=2
let g:airline_powerline_fonts = 1

let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }

let g:airline_skip_empty_sections = 1
let g:airline_section_x = '%{&filetype}'
let g:airline_section_y = airline#section#create(['ffenc'])
let g:airline_section_z = airline#section#create_right(['%P','%l:%c']) 
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1

"icons
let g:webdevicons_enable_airline_statusline = 0
