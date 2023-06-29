#!/usr/bin/env bash

conf_dir=~/.

#prepare files



#ensure ~/.config exists
[ -d $conf_dir ] || mkdir $conf_dir

ln -s ./nvim $conf_dir/nvim 
ln -s ./tmux $conf_dir/tmux
ln -s ./zshrc/.zshrc ~/.zshrc
