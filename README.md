## Installation:

    ```
    cd ~
    git clone http://github.com/chugachski/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    cd ~/.vim
    git submodule update --init
    ```

## Install plugins managed by vim-plug
see: https://github.com/junegunn/vim-plug

Plugins managed by vim-plug are extracted under the plugged directory.
All vim-plug plugins should appear between the call blocks in vimrc. ex:

    ```
    call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-unimpaired'
    call plug#end()
    ```

Install by running: `vim +PlugInstall` or run the command from vim.

## Pathogen
see: https://github.com/tpope/vim-pathogen

Include `execute pathogen#infect()` in vimrc to include the plugins found in the
bundle directory.

Add new pathogen plugins by running: `git submodule add <source url>
bundle/<plugin name>` as opposed to cloning. To update a single plugin:

    ```
    cd ~/.vim/bundle/vim-fugitive
    git pull origin master
    ```

To update all bundled plugins: `git submodule foreach git pull origin master`

[YouCompleteMe](https://github.com/ycm-core/YouCompleteMe).
Because YouCompleteMe has a build step, see documentation for advanced
installation instructions.
