set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'

" ==== Plugins START
Plugin 'nanotech/jellybeans.vim'
Plugin 'ctrlpvim/ctrlp.vim'  " Contrl-P
Plugin 'vim-airline/vim-airline'  " status bar
Plugin 'vim-airline/vim-airline-themes'  " status bar
Plugin 'tpope/vim-sleuth'  " Auto detect indentation with space or tab
Plugin 'nathanaelkane/vim-indent-guides'  " align guide
Plugin 'docunext/closetag.vim'  " auto close html tag
    autocmd FileType html,htmldjango let b:closetag_html_style=1
    autocmd FileType html,xhtml,xml,htmldjango source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

Plugin 'eslint/eslint' " eslint
Plugin 'dense-analysis/ale'
 "Plugin 'w0rp/ale'  " Syntax linter
Plugin 'digitaltoad/vim-pug'  " pug
Plugin 'sheerun/vim-polyglot'  " Syntax highlighter

Plugin 'airblade/vim-gitgutter'  " gitgutter
Plugin 'tpope/vim-fugitive' " git branch map
Plugin 'rbong/vim-flog' " git branch map

Plugin 'terryma/vim-multiple-cursors' " multiple cursor
Plugin 'preservim/nerdcommenter' " vim commenter
Plugin 'easymotion/vim-easymotion' " vim easymotion
" ==== Plugins END
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ==== Custom Functions START
" Converts unicode escaped strings to unicode
function! UnicodeUnescape()
  :%s#\\u[0-9a-f]*#\=eval('"'.submatch(0).'"')#g
endfunction
" ==== Custom Functions END

" === Configs START
syntax on
colorscheme jellybeans

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black

" set vim-airline
let g:airline_theme = 'bubblegum'

" set highlight
set hls

" Setup backspace
set backspace=indent,eol,start
" === Configs END

" === ag settings
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" CtrlP fast fuzzy file open
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.*,env,*.pyc,lib
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_user_command = 'ag %s -l -g ""'
endif

" remap leader
let mapleader=","

" Fast direcotry search
nmap <leader>apy :Ag --python "<c-r><c-w>"
nmap <leader>a :Ag "<c-r><c-w>"

" Highlight the occurance of current word, use following command to select color
" :so $VIMRUNTIME/syntax/hitest.vim
autocmd CursorMoved * exe printf('match VisualNOS /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Remove extra trailling spaces
autocmd BufWritePre * :%s/\s\+$//e

" TypeScript
set re=0

" tabs
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2

" display line number
" set nu " display line number
set rnu " display related line number

" set gitgutter color
highlight GitGutterAdd    ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red

" customize ale linter
let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'javascript': ['eslint'],
    \ 'typescript': ['tslint'],
    \ 'html': [],
    \ }

" auto-complete shortcut setup
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" set easymotion
let g:EasyMotion_do_mapping = 0
map <leader>f <Plug>(easymotion-bd-f)
