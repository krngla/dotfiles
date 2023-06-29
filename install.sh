#!/usr/bin/env bash

conf_dir=~/.config
bu_dir=~/tmp


#prepare files



function make_link {
	[[ -L $2 && -d $2 ]] && rm -rf $2 && echo Removed old symlink dir $2
	[[ -L $2 && -f $2 ]] && rm -rf $2 && echo Removed old symlink file $2
	[ -d $2 ] && rm -rf $2 && echo Removed old dir $2
	[ -f $2 ] && rm -rf $2 && echo Removed old file $2
	echo making link from $1 to $2
	ln -s $PWD/$1 $2 
}



#ensure ~/.config exists
[ -d $conf_dir ] || mkdir $conf_dir

make_link nvim $conf_dir/nvim
make_link tmux $conf_dir/tmux
make_link zshrc/.zshrc ~/.zshrc

