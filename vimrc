" Setup Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim

" Keyboard mods
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <C-b> :NERDTreeToggle<CR>

" Settings
set backspace=indent,eol,start
set omnifunc=syntaxcomplete#Complete
syntax on
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set number
set cursorline
set showmatch
set incsearch
set hlsearch
let g:ctrlp_working_path_mode = 'r'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/* " lol
let g:ctrlp_show_hidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set noswapfile

" Start Pathogen
execute pathogen#infect()
call pathogen#helptags()

" Colorscheme
colorscheme dracula
set noruler
set noshowmode
set hidden

