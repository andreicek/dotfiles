set mouse=a
set number
set tabstop=2

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
" {{{
  autocmd vimenter * NERDTree
  map <C-n> :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  let NERDTreeShowHidden=1
  let NERDTreeIgnore = ['node_modules', '.git']
" }}}

"" Fuzzy search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting
  nnoremap <silent> <leader>ff :Files<CR>
  nnoremap <silent> <leader>fb :Buffers<CR>
  nnoremap <silent> <leader>fw :Windows<CR>
  nnoremap <silent> <leader>fl :BLines<CR>
  nnoremap <silent> <leader>ft :BTags<CR>
  nnoremap <silent> <leader>fh :History<CR>
  nnoremap <silent> <leader>fm :Maps<CR>
  nnoremap <silent> <leader>fs :Snippets<CR>
  nnoremap <silent> <leader>fy :Filetypes<CR>
" }}}

Plug 'gabrielelana/vim-markdown'

call plug#end()

" Colors {{{
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  syntax enable
  set background=dark
" }}} Colors

" Spaces & Tabs {{{
  set tabstop=2
  set softtabstop=2  
  set shiftwidth=2
  set expandtab
  set autoindent
  set copyindent
" }}} Spaces & Tabs
