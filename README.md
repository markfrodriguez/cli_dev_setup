# CLI Development Setup

Ultimate goal is the setup of a productive command line based development environment for the Rust programming language. The configuration files for both [tmux](https://github.com/tmux/tmux) and [nvim](https://neovim.io) are included in the repository along with some general notes in this Readme file so the setup can be easily reproduced in the future on other workstations.

My setup happens to be on an AWS E2 instance, but should work with any Debian / Ubuntu based Linux distribution.

## Keeping Linux Up-to-Date

Run the following commands individually.

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
```

or run the single command below

```
sudo apt-get update && time sudo apt-get dist-upgrade
```

## General Linux Utilities

```
sudo apt-get install htop
sudo apt-get install tmux
sudo apt install curl
```

## tmux
If not already installed, run `sudo apt-get install tmux`. The configuration file resides in the root of the user's home directory. For me, that's `/home/macrod/.tmux.conf`.

When playing with the `.tmux.conf` file, either detach from and then reattach to tmux or run `tmux source-file ~/.tmux.conf`.

## Core Development Tools

The following packages are desirable for a sane development box.

```
sudo apt-get install git
sudo apt-get install build-essential
sudo apt-get install manpages-dev man-db manpages-posix-dev
sudo apt-get install libncurses-dev
```

## nvim
A version > 0.3.x of Neovim is required for this setup (a requirement of Deoplete plugin). If an older version of neovim is already installed, remove it with the following commands:

```
sudo apt-get --purge remove neovim
sudo apt autoremove
```

To install the latest stable version of neovim, execute the commands below:

```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```

The configuration file for neovim lives at `~/.config/nvim/init.vim`.

Let's make sure we ALWAYS use neovim and not vim by creating the following aliases.

```
alias vim='nvim'
alias vimdiff='nvim -d'
```

*My preference is for any custom aliases to be in `~/.bash_aliases`, but they could also go in `~/.bashrc` if that's your thing.*

Some basic commands to manage plugins:

* Install plugins: `:PlugInstall`
* Update plugins: `:PlugUpdate`
* Remove plugins: `:PlugClean` (First, comment the plugin install command in init.vim. Open Nvim and use :PlugClean to uninstall plugins)
* Check the plugin status: `:PlugStatus`
* Upgrade vim-plug itself: `:PlugUpgrade`

## Plugins
The setup involves several plugins to produce the best Rust development environment possible so [vim-plug](https://github.com/junegunn/vim-plug) is employed to handle and manage them. To install vim-plug, run the following commands:

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
The [tagbar](https://github.com/majutsushi/tagbar) pluggin depends on Ctags, which can be installed by running `sudo apt install exuberant-ctags`.

Below is a snippet from the vim configuration file listing all the installed plugins.

```
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
```

*All the plugins are "installed" by executing `:PlugInstall` within neovim.*

*Deoplete and LanguageClient use remote plugins so install using the command below.*

```
nvim +PlugInstall +UpdateRemotePlugins +qa
```
`
