set nocompatible              " be iMproved, required
filetype off                  " required
:syntax on
set ruler
:set ignorecase
"set autoindent
"set smartindent
set laststatus=2
"set statusline=%F "tail of the filename
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'


"Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required


"Search for strings with slashes, without escaping them, with :SS
command! -nargs=1 SS let @/ = '\V'.escape(<q-args>, '\')

" Plug plugins
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
" show file line I guess
Plug 'lervag/file-line'
" cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" comment out blocks of code
Plug 'scrooloose/nerdcommenter'
" gyp highlighting
Plug 'kelan/gyp.vim'
" gn highlighting
Plug 'c0nk/vim-gn'
" qbs highlighting
Plug 'https://JohnKaul@bitbucket.org/JohnKaul/qbs.vim.git'
" Not sure what this is for
Plug 'nathanaelkane/vim-indent-guides'
" colorscheme
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
" Remember last cursor position
Plug 'dietsche/vim-lastplace'
" Ack / ag integration
Plug 'mileszs/ack.vim'
" ripgrep integration
Plug 'jremmen/vim-ripgrep'
" Fuzzy file finder
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" File explorer
Plug 'scrooloose/nerdtree'
" Smart status bar
Plug 'vim-airline/vim-airline'
" Git integration
Plug 'tpope/vim-fugitive'
" nginx syntax highlighting
Plug 'chr4/nginx.vim'
" qmake syntax highlighting
Plug 'artoj/qmake-syntax-vim'
" qml syntax highlighting
Plug 'peterhoeg/vim-qml'
" Git gutter integration
Plug 'airblade/vim-gitgutter'
" Git a vim
Plug 'jreybert/vimagit'
" extend selection expand selection
Plug 'terryma/vim-expand-region'
" tig support
if has('nvim')
    Plug 'codeindulgence/vim-tig'
    let g:tig_default_command = ''
endif
" Toml support
Plug 'cespare/vim-toml'
" Switch between header and source files with :A
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/alternate-lite'

" Motion highlighting
Plug 'easymotion/vim-easymotion'

" Buffer explorer (similar to Ctrl+Tab in Qt Creator)
set runtimepath^=~/.vim/bundle/buffet

" Initialize plugin system
call plug#end()

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let c_no_curly_error=1

" Smart indent
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

" set qmake project files comment strings
autocmd FileType qmake set commentstring=#\ %s

"let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" save undo history for documents
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
  endif

" Replace Ack with Ag
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" Replace Ack with ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" Use fuzzy file finder
set rtp+=~/fzf/bin/fzf

" Best colorscheme found
colorscheme jellybeans

" map fzf keybindings
nmap ,t :Files<CR>
nmap ,f :Files<CR>
nmap ,b :Buffers<CR>
nmap <C-P> :Files<CR>

" map ",cd" to changing directory to current open file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" map \s to update the save the current file if it was updated (simiarl to :w)
nnoremap <Leader>s :update<cr>

" map ,gb to Tig blame current file
nnoremap ,gb :exe ':Tig blame '. @%<cr>

" map ,gt to Tig
nnoremap ,gt :exe ':Tig '<cr>

" map ,gt to Tig diff
nnoremap ,gd :exe ':Tig'<cr>d

" open nerdtree shortcut
map ,n :NERDTreeToggle<CR>
map ,m :NERDTreeFind<CR>

" Type :e %%/filename to edit file in same dir as currently opened file
cabbr <expr> %% expand('%:p:h')

" replace selection with paste, without changing default register content
vnoremap <space>p "_dP

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Alt Tab switching between buffers.
noremap <F10> :Bufferlistsw<CR>
noremap <F11> :Bufferlistsw<CR>kk

" Maps Ctrl F10 and Ctrl F11 to switch buffers. iTerm2 is configured to send
" that when pressing Alt-Tab and Alt-Shift-Tab.
augroup BuffetAdd
   if !exists("g:BuffetAdded")
      let g:BuffetAdded = 1
      au BufWinEnter buflisttempbuffer* map <buffer> <Tab> <CR>
      au BufWinEnter buflisttempbuffer* map <buffer> <Esc>[21~   j
      au BufWinEnter buflisttempbuffer* map <buffer> <Esc>[23~ k
   endif
augroup END

" Enable mappings for terminal
if has('nvim')
   tnoremap <Esc> <C-\><C-n>
   tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif

" Allow saving of files as sudo when I forgot to start vim using sudo.
" cmap w!! w !sudo tee > /dev/null %
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Set updatetime to 1sec for git gutter plugin
set updatetime=1000

" Set text width to 71 chars for git commit message editing
au FileType gitcommit setlocal tw=70

" Open Nerdtree when editing a directory
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Don't use nerdtree when editing a dir directlry, use netrw instead
let NERDTreeHijackNetrw = 0

" Spellchecking git commit messages
autocmd FileType gitcommit setlocal spell
