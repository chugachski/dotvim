" plugins expect bash, not fish, zsh, etc
set shell=bash

" vim-plug package manager
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' " https://github.com/morhetz/gruvbox/wiki/Installation
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sensible'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'gabrielelana/vim-markdown'
Plug 'preservim/nerdtree'
call plug#end()

" pathogen plugin manager
" load modules in the bundle directory
" execute pathogen#infect()
call pathogen#infect()
call pathogen#helptags()

" set colorscheme
" see: https://github.com/morhetz/gruvbox
colorscheme gruvbox
" set t_ut= " for the benefit of tmux

" change map leader (<leader>) to ','
let mapleader=","

" use dark colors by default
set background=dark

" allow hidden buffers to be created without raising error
set hidden

" move .swp files to /tmp
set directory=/tmp

" remember 50 commands
set history=50

" change the key used to exit insert mode
inoremap jk <ESC>

" shortcut to rapidly toggle `set list` (show invisibles)
nmap <leader>l :set list!<CR>

" shortcut to open vimrc file
nmap <leader>v :tabedit $MYVIMRC<CR>

" open nerdtree menu
nnoremap <leader>nt :NERDTreeToggle<Enter>
" nerdtree find
nnoremap <silent> <Leader>nf :NERDTreeFind<CR>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" bubble single lines with unimpaired plugin using remapped commands
nmap <C-Up> [e
nmap <C-Down> ]e
" bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:∙,nbsp:•

" set tabstop=8 softtabstop=0 shiftwidth=8 noexpandtab "default vim settings
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab "default values

" formatting options
au FileType * set formatoptions-=o " do not insert a comment leader after hitting 'o' or 'O'
set textwidth=80

" highlight the 81th column on overly long lines
" https://stackoverflow.com/a/21406581
augroup columnLimit
    autocmd!
    autocmd BufEnter,WinEnter,FileType ruby,php,javascript,go
                \ highlight ColumnLimit ctermbg=DarkGrey guibg=DarkGrey
    let columnLimit = 81
    let pattern =
                \ '\%<' . (columnLimit+1) . 'v.\%>' . columnLimit . 'v'
    autocmd BufEnter,WinEnter,FileType ruby,php,javascript,go
                \ let w:m1=matchadd('ColumnLimit', pattern, -1)
augroup END

" shortcuts for changing windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" shortcuts for opening files in the same directory as the current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" custom command to wrap around words
command! -nargs=* Wrap set wrap linebreak nolist

" custom command to show that your environment is initialized
" (use when moving to new machine)
command! Status echo "All systems are go!"

" remove trailing whitespace on a line with F5
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" include all autocmd lines in here for portability
if has("autocmd")
    " enable file type detection
    filetype plugin indent on

    " syntax of these langs is fussy over tabs vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " file specific customizations
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd fileType sh setlocal ts=2 sts=2 sw=2 expandtab

    " get rid of accidental trailing whitespace on save
    autocmd BufWritePre *.rb,*.js,*.jsx,*.py,*.php,*.html,*.css,*.scss,*.scss
                \ :call <SID>StripTrailingWhitespaces()

    " restore cursor position
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \ endif

    " Source the vimrc file after saving it
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

if &t_Co > 2 || has("gui_running")
    " Enable syntax highlighting
    syntax on
endif

" tell the syntastic module when to run
" want to see code highlighting and checks when  we open a file
" but we don't need it to rerun when we close the file
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ruby omnicompletion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" =============================================================== golang
" see: https://coolaj86.com/articles/getting-started-with-golang-and-vim/

" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
" =========================================================== end golang
