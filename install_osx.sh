#!/bin/zsh

if [ $OPTIND -eq 1 ]; then
  echo """usage (osx):
    -n normal : tmux, nvim, coc-jedi, clang
    """
fi

while getopts "nrszd" opt; do
  case $opt in
    n)
      ## vim
      sudo apt-get install software-properties-common

      ## tmux
      brew install tmux

      # neovim install
      brew install neovim
      brew install nodejs
      brew install yarn

      # nvimrc setting
      mkdir ~/.config/nvim
      cp dotfiles/.nvimrc ~/.config/nvim/init.vim
      cp coc-settings.json ~/.config/nvim/coc-setting.json
      ln -s ~/.config/nvim/init.vim ~/.nvimrc

      #vim-plug
      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

      ## fzf
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install

      ## ag
      sudo apt-get install silversearcher-ag

      ## coc
      echo "run following commands in nvim"
      echo "PlugInstall"
      echo "CocInstall coc-jedi"
      echo "CocInstall coc-explorer"

      ;;
  esac
done

