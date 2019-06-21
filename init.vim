" Mark F Rodriguez
"   neovim configuration file targeted at Rust development
"   Influenced by - https://gist.github.com/bjonica/addb3e2d5608524e33b8

" {{{ VIM Plugins -------------------------------------------------------------
  call plug#begin('~/.local/share/nvim/plugged')
    " Directory browser
    Plug 'scrooloose/nerdtree'
    
    " Status / tabline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    " remove buffers without closing splits
    Plug 'qpkorr/vim-bufkill'
    
    " Git Gutter
    Plug 'airblade/vim-gitgutter'
    
    " Fugitive for awesome git stuff
    Plug 'tpope/vim-fugitive'
    
    " Syntax checker for all sorts of languages
    Plug 'scrooloose/syntastic'
    
    " tagbar
    Plug 'majutsushi/tagbar'
    
    " Run programs asynchronously
    Plug 'neomake/neomake'
    
    " Code completion
    "Plug 'Shougo/deoplete.nvim'
    
    " TOML support
    Plug 'cespare/vim-toml'
    
    " Rust support
    Plug 'rust-lang/rust.vim'
    
  " -------- put all plugins before this line --------
  call plug#end()
" }}}

" {{{ General Setup -----------------------------------------------------------
  " {{{ Encodings
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8
    set bomb
    set binary
  " }}}
  
  " {{{ Visual
    " fix backspace indent
    set backspace=indent,eol,start
    
    " enable syntax processing
    syntax enable
    
    " turn on syntax highlighting
    syntax on
    
    " show ruler
    set ruler
    
    " show line numbers
    set number
    
    " colorcolumn at 80 by default
    set colorcolumn=80
    
    " Set window update time
    set updatetime=250
    
    " highlight last inserted text
    nnoremap gV `[v`]
    
    " show command in bottom bar
    set showcmd

    " highlight current line
    set cursorline

    " load filetype-specific indent files
    filetype plugin indent on

    " visual autocomplete for command menu
    set wildmenu

    " redraw only when we need to (speeds up macros)
    set lazyredraw

    " highlight matching [{()}]
    set showmatch
  " }}}
  
  " {{{ Spaces & Tabs
    " NOTE: May be overriten by autocmd rules
    " number of visual spaces per TAB
    set tabstop=2
    set shiftwidth=2

    " number of spaces in tab when editing
    set softtabstop=2

    " tabs are spaces
    set expandtab
  " }}}
  
  " {{{ Searching
    " search as characters are entered
    set incsearch

    " highlight matches
    set hlsearch
    
    " ignore case
    set ignorecase
    
    " but still search by case for uppercase characters
    set smartcase
  " }}}
  
  " {{{ Folding
    " enable folding
    set foldenable

    " open most folds by default
    set foldlevelstart=10

    " 10 nested fold max
    set foldnestmax=10

    " space opens/closes folds 
    "nnoremap <space> za      DISABLED due to conflict with nohlsearch binding

    " fold based on syntax
    set foldmethod=syntax
  " }}}
  
  " {{{ Line Shortcuts
    " move vertically by visual line (helps with wraps)
    nnoremap j gj
    nnoremap k gk

    " move to beginning/end of line
    nnoremap B ^
    nnoremap E $
  " }}}
  
  " {{{ Splits
    " Navigate splits with ctrl-j/k/h/l
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-H> <C-W><C-H>
    nnoremap <C-L> <C-W><C-L>

    " open splits to the right and bottom
    set splitbelow
    set splitright
  " }}}
  
  " {{{ Miscellaneous
    " add a hidden mode for buffers to avoid needing to save
    " current buffer every time you do a goto-definition
    set hidden
    
    set fileformats=unix,dos,mac
    set showcmd
    set shell=/bin/sh
  " }}}
  
  " {{{ Backups
    " no backups
    set nobackup
    
    " no swap file
    set noswapfile
  " }}}

  " {{{ Session management
    let g:session_directory = "~/.config/nvim/session"
    let g:session_autoload = "no"
    let g:session_autosave = "no"
    let g:session_command_aliases = 1
  " }}}
" }}}

" {{{ Auto Groups -------------------------------------------------------------
  " language/file-specific settings
  augroup configgroup
    autocmd!
    autocmd BufWritePre *.c,*.cpp,*.h,*.py,*.md,*.java,*.txt,*.rs
          \ call <SID>StripTrailingWhitespaces()

    " Rust
    autocmd FileType rust setlocal tabstop=4
    autocmd FileType rust setlocal shiftwidth=4
    autocmd FileType rust setlocal softtabstop=4
    autocmd FileType rust setlocal colorcolumn=99
  augroup END
" }}}

" {{{ Custom Leader Shortcuts -------------------------------------------------
  " Map leader to ,
  let mapleader=",""
  
  " turn off search highlight
  nnoremap <leader><space> :nohlsearch<CR>
  
  " next buffer
  nnoremap <leader>ll :bnext<CR>

  " prev buffer
  nnoremap <leader>hh :bprevious<CR>
  
  " delete buffer
  "nnoremap <leader>xx :bprevious | :bdelete #<CR>
  " using bufkill plugin
  nnoremap <leader>xx :BD<CR>
  
  " tab close with ,tc
  nnoremap <leader>tc :tabclose<CR>
  
  " toggle NERDTree
  nnoremap <leader>nt :NERDTreeToggle<CR>
  
  " Git status
  nnoremap <leader>gs :Gstatus<CR>

  " toggle tagbar
  nnoremap <leader>tt :TagbarToggle<CR>
" }}}

" {{{ Custom Functions --------------------------------------------------------
  " strip trailing whitespace at end of files
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
" }}}
    
" {{{ Plugin Settings ---------------------------------------------------------
  " {{{ NERDTree
    " show .files by default
    let NERDTreeShowHidden=1
  " }}}

  " {{{ Airline
    " let laststatus show at all times
    set laststatus=2
    
    " display all buffers when there's only one tab open
    let g:airline#extensions#tabline#enabled = 1
    
    " enable syntastic integration
    let g:airline#extensions#syntastic#enabled = 1
    
    " enable dark mode
    let g:airline_theme = 'dark'
  " }}}
  
  " {{{ Git Gutter
    " Symbols to show in gutter
    let g:gitgutter_sign_added = '+'
    let g:gitgutter_sign_modified = '>'
    let g:gitgutter_sign_removed = '-'
    let g:gitgutter_sign_removed_first_line = '^'
    let g:gitgutter_sign_modified_removed = '<'
  " }}}

  " {{{ Syntastic
    " Recommended settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
  
    " make the error list a little shorter
    let g:syntastic_loc_list_height = 5
  " }}}
  
  " {{{ Tagbar
    " autofocus on tagbar on open
    let g:tagbar_autofocus = 1
  " }}}
  
  " {{{ Neomake
    " open location list automatically
    let g:neomake_open_list = 2
  " }}}
  
  " {{{ Rust
    " auto format code on bufwrite
    let g:rustfmt_autosave = 1

    " fail silently if cant format
    let g:rustfmt_fail_silently = 1
  " }}}
" }}}
