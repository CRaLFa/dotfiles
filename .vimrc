set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set cursorline
set display=lastline
set expandtab
set helpheight=999
set helplang=ja
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list listchars=tab:›\ ,trail:･,eol:↲
set mouse=a
set nobackup
set noswapfile
set nowrap
set number
set pumheight=10
set shiftwidth=4
set showcmd
set showmatch matchtime=1
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set updatetime=100
set virtualedit=onemore
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildmode=list:longest
set wrapscan

nnoremap / /\v
nnoremap Y y$
nnoremap <Esc>z :set wrap!<CR>

let s:dot_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" Netrw filer settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_winsize = 80

" lightline.vim settings
let g:lightline = {
\   'colorscheme': 'wombat'
\ }

" comfortable-motion.vim settings
let g:comfortable_motion_interval = 1200.0 / 60
let g:comfortable_motion_friction = 100.0
let g:comfortable_motion_air_drag = 3.0

" winresizer.vim settings
let g:winresizer_start_key = '<C-s>'
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" previm settings
let g:previm_open_cmd = '/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
let g:previm_wsl_mode = 1
" let g:previm_disable_default_css = 1
let g:previm_custom_css_path = s:dot_dir . '/vim/markdown.css'

" Jump to the last edited position
if has('autocmd')
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line('$') |
  \   exe 'normal g`"' |
  \ endif
endif

" Install plugins using dein.vim
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
endif

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    exe '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif

  exe 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = s:dot_dir . '/vim/dein.toml'
  if filereadable(s:toml)
    call dein#load_toml(s:toml, { 'lazy': 0 })
  endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

syntax enable
filetype plugin indent on
colorscheme codedark
