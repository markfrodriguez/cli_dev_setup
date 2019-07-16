" Mark F Rodriguez
"   neovim configuration file targeted at Rust development
"   Influenced by - https://gist.github.com/bjonica/addb3e2d5608524e33b8

" {{{ VIM Plugins -------------------------------------------------------------
  call plug#begin('~/.local/share/nvim/plugged')
    " vim Dracula color theme
    Plug 'dracula/vim'
    
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
    
    " auto close brackets
    Plug 'cohama/lexima.vim'
    
    " Run programs asynchronously
    Plug 'neomake/neomake'
    
    " Code completion
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    
    " TOML support
    Plug 'cespare/vim-toml'
    
    " Rust support
    Plug 'rust-lang/rust.vim'
    
    " Language Client
    Plug 'autozimu/LanguageClient-neovim', {
       \ 'branch': 'next',
       \ 'do': 'bash install.sh',
       \ }
    
  " >>>>>>>> put all plugins before this line <<<<<<<<
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
    
    " set color theme
    color dracula
    
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
    
" {{{ Plugin Settings ---------------------------------------------------------
  " {{{ NERDTree :help NERDTree.txt
    " show .files by default
    let NERDTreeShowHidden=1
    
    " close vim if only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " }}}

  " {{{ Airline :help airline
    " let laststatus show at all times
    set laststatus=2
    
    " display all buffers when there's only one tab open
    let g:airline#extensions#tabline#enabled = 1
    
    " enable syntastic integration
    let g:airline#extensions#syntastic#enabled = 1
    
    " enable dracula color theme
    let g:airline_theme = 'dracula'
  " }}}
  
  " {{{ Git Gutter
    " Symbols to show in gutter
    let g:gitgutter_sign_added = '+'
    let g:gitgutter_sign_modified = '>'
    let g:gitgutter_sign_removed = '-'
    let g:gitgutter_sign_removed_first_line = '^'
    let g:gitgutter_sign_modified_removed = '<'
  " }}}

  " {{{ Syntastic :help syntastic
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
  
  " {{{ Tagbar :help tagbar
    " autofocus on tagbar on open
    let g:tagbar_autofocus = 1
    
    " Rust specific settings for tags
    let g:tagbar_type_rust = {
        \ 'ctagstype' : 'rust',
        \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
        \]
        \}
  " }}}
  
  " {{{ Lexima
    " basic rules
    let g:lexima_enable_basic_rules = 1
    " new line rules
    let g:lexima_enable_newline_rules = 1
    " endwise rules
    let g:lexima_enable_endwise_rules = 0
  " }}}
  
  " {{{ Neomake :help neomake.txt
    " open location list automatically
    let g:neomake_open_list = 2
  " }}}
  
  " {{{ Deoplete :help deoplete-options
    " auto start
    let g:deoplete#enable_at_startup = 1
  " }}}
  
  " {{{ Rust : help rust
    " set filetype
    autocmd BufReadPost *.rs setlocal filetype=rust
    
    " auto format code on bufwrite
    let g:rustfmt_autosave = 1

    " fail silently if unable to format
    let g:rustfmt_fail_silently = 1
  " }}}
  
  " {{{ Language Client :help LanguageClient
    " set server commands
    let g:LanguageClient_serverCommands = {
        \ 'rust': ['rls'],
        \ 'python': ['/usr/local/bin/pyls'],
        \ }

    " automatically start language servers.
    let g:LanguageClient_autoStart = 1
    
    " handle diagnostic messages
    let g:LanguageClient_diagnosticsEnable=1
    
    " use vim's formatting operator |gq|
    set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
  " }}}
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
  
  " LanguageClient context menu
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
  
  " show type info (and short doc) of identifier under cursor
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  
  " goto definition under cursor
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  
  " rename identifier under cursor
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  
  " format current document
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  
  " goto type definition under cursor
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  
  " list all references of identifier under cursor
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  
  " apply a workspace edit
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  
  " get a list of completion items at current editing location
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  
  " list of current buffer's symbols
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
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

