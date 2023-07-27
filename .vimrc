" General settings
set nocompatible              " be iMproved, required

" Each time a new or existing file is edited, Vim will try to recognize the type
" of the file and set the 'filetype' option.  This will trigger the FileType
" event, which can be used to set the syntax highlighting, set options, etc.
" TODO: Why is off required?
filetype off                  " required

" Enables syntax highlighting
:syntax on

" Enables ruler, but actually doesn't seem to do much when using neovim full
" of plugins
set ruler

" Ignore case when searching
set ignorecase

" Copy indent from current line when starting a new line
"set autoindent

" Do smart autoindenting when starting a new line. Works for C-like
" programs
"set smartindent

" Always show status line
set laststatus=2

" Allow backspace removing whitespace in normal mode
set backspace=indent,eol,start

" Enable relative line numbers hybrid with absolute
set number
set relativenumber

" Show right-side column count margins
set colorcolumn=72,80,100

" TODO: Unclear
"set statusline=%F "tail of the filename


" disable syntax highlighting in big files
function DisableSyntaxTreesitter()
    echo("Big file, disabling syntax, treesitter and folding")
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
        " etc...
    endif

    set foldmethod=manual
    syntax clear
    syntax off    " hmmm, which one to use?
    filetype off
    set noundofile
    set noswapfile
    set noloadplugins
endfunction

augroup BigFileDisable
    autocmd!
    " autocmd BufWinEnter * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif

augroup END


" Initialize plugins
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Allow opening files with columns like main.txt:12
Plug 'lervag/file-line'

" comment out blocks of code
Plug 'scrooloose/nerdcommenter'

" Show indentation levels of code
"Plug 'nathanaelkane/vim-indent-guides'

" colorscheme
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }

" Remember last cursor position
Plug 'dietsche/vim-lastplace'

" Ack / ag integration
Plug 'mileszs/ack.vim'

" ripgrep integration
Plug 'jremmen/vim-ripgrep'

" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File explorer
Plug 'scrooloose/nerdtree'

" Smart status bar
Plug 'vim-airline/vim-airline'

" Git integration
Plug 'tpope/vim-fugitive'

" Git gutter integration
Plug 'airblade/vim-gitgutter'

" Git a vim
Plug 'jreybert/vimagit'

" Lua helpers for neogit
Plug 'nvim-lua/plenary.nvim'

" extend selection expand selection + and _
Plug 'terryma/vim-expand-region'

" Additional text-objects for viw like commands
"Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'

" Switch between header and source files with :A
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/alternate-lite'

" Motion highlighting
Plug 'easymotion/vim-easymotion'

" Alternative trying out
" Plug 'rlane/pounce.nvim'

" Buffer explorer (similar to Ctrl+Tab in Qt Creator)
" Doesn't work atm
" set runtimepath^=~/.vim/bundle/buffet

" Visualize undo tree
Plug 'mbbill/undotree'

" Indentation level text objects
Plug 'michaeljsmith/vim-indent-object'

" Set indent space or tabs based on file contents
Plug 'tpope/vim-sleuth'


" Syntax highlighters
" Toml support
Plug 'cespare/vim-toml', { 'branch': 'main' }

" nginx syntax highlighting
Plug 'chr4/nginx.vim'

" qmake syntax highlighting
Plug 'artoj/qmake-syntax-vim'

" qml syntax highlighting
Plug 'peterhoeg/vim-qml'

" gyp highlighting
Plug 'kelan/gyp.vim'

" gn highlighting
Plug 'c0nk/vim-gn'

" qbs highlighting
Plug 'https://JohnKaul@bitbucket.org/JohnKaul/qbs.vim.git'

" cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight'


" tig support
if has('nvim')
    Plug 'codeindulgence/vim-tig'
    let g:tig_default_command = ''
endif

" Telescope fzf like replacement
if has('nvim')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': ':split term://cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    " Show recently open files
    Plug 'smartpde/telescope-recent-files', { 'branch': 'main'}

    " for git mergetool
    " Plug 'sindrets/diffview.nvim'

    " Magit git like experience
    "Plug 'TimUntersberger/neogit'
    Plug 'NeogitOrg/neogit'
    "Plug 'CKolkey/neogit'

    " Lazygit
    Plug 'kdheepak/lazygit.nvim', { 'branch': 'main' }
endif


" Install treesitter for telescope
if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" Do gradgual undos with u, where first cursor goes to where the change will
" happen, and only second u will undo, like in other IDEs.
" Somehow breaks undo sometimes
"if has('nvim')
    "Plug 'EtiamNullam/gradual-undo.nvim'
"endif

" Show indentation levels better
if has('nvim')
    Plug 'lukas-reineke/indent-blankline.nvim'
endif

" vim keybindings popup guide
if has('nvim')
    Plug 'folke/which-key.nvim', { 'branch': 'main' }
endif

" Copilot
if has('nvim')
    Plug 'github/copilot.vim', { 'branch': 'release' }
endif

if has('nvim')
    " Like easy motion
    Plug 'folke/flash.nvim', { 'branch': 'main' }
endif

if has('nvim')
    " Use zoxide directory recency jumping
    Plug 'nanotee/zoxide.vim'
endif

" Live preview of :global + :substitute
"if has('nvim')
    "Plug 'chentoast/live.nvim'
"endif

" Live preview of :global + :substitute v2
"Plug 'markonm/traces.vim'

" Initialize plugin system
call plug#end()

" Use surround.vim keymap for vim-sandwhich, to not override default motions
"runtime macros/sandwich/keymap/surround.vim


" Telescope fzf c faster impl
if has('nvim')
    lua if jit ~= nil then require('telescope').load_extension('fzf') end
endif

" Bind <leader>; to reopen latest telescope window
if has('nvim')
   lua vim.keymap.set("n", "<leader>;", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", opts)
endif

" Telescope which key help guide popup show
"if has('nvim')
    "lua require('telescope').setup{} end
"endif

" Enable gradual undo
"if has('nvim')
    "lua require('gradual-undo').setup()
"endif

" Enable indentation highlighting
if has('nvim')
    lua require("indent_blankline").setup()
endif

" which key settings
if has('nvim')
    lua require("which-key").setup {}
endif

" Bindings for easymotion flash movement
if has('nvim')
    " Enables regular search jump labels and f,t motions
    lua require("flash").setup { modes = {search = {enabled = false}}}
    lua vim.keymap.set({"n", "x", "o"}, "<leader>w", "<cmd>lua require('flash').jump()<cr>", opts)
endif

if has ('nvim')
    " Load telescope recent files and set binding
    lua require("telescope").load_extension("recent_files")
    lua vim.keymap.set("n", "<leader>r", "<cmd>lua require('telescope').extensions.recent_files.pick()<cr>", opts)
endif

if has('nvim')
    lua require("neogit").setup()
endif

" Enable live preview of :global command
" Doesn't work for nested :subs
"if has('nvim')
    "lua require("live").setup()
"endif

" vim-cpp-enhanced-highlight options
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let c_no_curly_error=1

"Search for strings with slashes, without escaping them, with :SS
command! -nargs=1 SS let @/ = '\V'.escape(<q-args>, '\')

" Smart indent
filetype plugin indent on

" show existing tab with 4 spaces width
"set tabstop=4

" " when indenting with '>', use 4 spaces width
"set shiftwidth=4

" " On pressing tab, insert 4 spaces
set expandtab

" Disable mouse visual select
set mouse=

" set qmake project files comment strings
autocmd FileType qmake set commentstring=#\ %s

" vim-indent-guides options
" If not enabled on startup, use :IndentGuidesToggle to enable
"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1

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

" Best colorscheme found
colorscheme jellybeans

" map leader to space
map <SPACE> <leader>

" map fzf keybindings
nmap <leader>zt :Files<CR>
nmap <leader>zf :Files<CR>
nmap <leader>zb :Buffers<CR>
nmap <C-P> :Files<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <C-[> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <C-]> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope treesitter<cr>
nnoremap <leader>fc <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>ft <cmd>Telescope <cr>

" Trigger lazygit
nnoremap <silent> <leader>gg :LazyGit<CR>

" Trigger neogit
nnoremap <silent> <leader>ng :Neogit<CR>

" map "leader cd" to changing directory to current open file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" map \s to update the save the current file if it was updated (simiar to :w)
nnoremap <Leader>s :update<cr>

" map ,gb to Tig blame current file
nnoremap <leader>gb :exe ':Tig blame '. @%<cr>

" map ,gt to Tig
nnoremap <leader>gt :exe ':Tig '<cr>

" map ,gt to Tig diff
nnoremap <leader>gd :exe ':Tig'<cr>d

" open nerdtree shortcut
map <leader>tt :NERDTreeToggle<CR>
map <leader>tm :NERDTreeFind<CR>
map <leader>tc :NERDTreeCWD<CR>

" Open zoxide fzf jump
map <leader>o :Zi<CR>

" Type :e %%/filename to edit file in same dir as currently opened file
cabbr <expr> %% expand('%:p:h')

" replace selection with paste, without changing default register content
vnoremap <space>p "_dP

" text object to select a line
xnoremap <silent> il :<c-u>normal! g_v^<cr>
onoremap <silent> il :<c-u>normal! g_v^<cr>

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

" Alt Tab switching between buffers, using Buffet plugin.
" noremap <F10> :Bufferlistsw<CR>
" noremap <F11> :Bufferlistsw<CR>kk

" Maps Ctrl F10 and Ctrl F11 to switch buffers. iTerm2 is configured to send
" that when pressing Alt-Tab and Alt-Shift-Tab.
"augroup BuffetAdd
   "if !exists("g:BuffetAdded")
      "let g:BuffetAdded = 1
      "au BufWinEnter buflisttempbuffer* map <buffer> <Tab> <CR>
      "au BufWinEnter buflisttempbuffer* map <buffer> <Esc>[21~   j
      "au BufWinEnter buflisttempbuffer* map <buffer> <Esc>[23~ k
   "endif
"augroup END

" Enable mappings for terminal
if has('nvim')
   tnoremap <Esc> <C-\><C-n>
   tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif

" Enable incremental selection expansion
if has('nvim')
    lua <<EOF
        require'nvim-treesitter.configs'.setup {
          incremental_selection = {
            enable = true,
            keymaps = {
              node_incremental = "v",
              node_decremental = "V",
            },
          },
        }
EOF
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
