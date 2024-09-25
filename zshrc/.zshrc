

zstyle :compinstall filename '$HOME/.zshrc'

alias ttmux='TERM=xterm-256color tmux'

[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit;}
autoload -Uz colors compinit vcs_info
colors
compinit


REPORTTIME=3
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
#setopt extendedglob nomatch

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt CORRECT_ALL
unsetopt beep

export PATH=~/.local/scripts:/opt/bin:/opt/bin/lib:/opt/inc:$PATH
export LD_LIBRARY_PATH=/opt/bin/lib:$LD_LIBRARY_PATH

zstyle ':completion:*' completer _complete _correct _approximate

zstyle ':vcs_info:*' stagedstr '%F{green}●%f '
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f '
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{blue}%b%f %u%c"
_setup_ps1() {
	vcs_info
	GLYPH="▲"
	[ "x$KEYMAP" = "xvicmd" ] && GLYPH="▼"
	PS1=" %(?.%F{green}.%F{red})$GLYPH %F{214}%n%(?.%F{green}.%F{red})@%m %f %(1j.%F{cyan}[%j]%f .)%F{blue}%(5~|%-1~/…/%3~|%4~)%f %(!.%F{red}#%f .)"
	#PS1=" %(?.%F{green}.%F{red})$GLYPH %F{214}%n%(?.%F{green}.%F{red})@%m %f %(1j.%F{cyan}[%j]%f .)%F{blue}%~%f %(!.%F{red}#%f .)"
	RPROMPT="$vcs_info_msg_0_"
}
_setup_ps1
# Vi mode
zle-keymap-select () {
	_setup_ps1
	zle reset-prompt
}
zle -N zle-keymap-select
zle-line-init () {
	zle -K viins
}
zle -N zle-line-init
bindkey -v


#oldprompt
#PROMPT='%F{blue}[%F{yellow}%n%F{red}@%F{magenta}%m %F{cyan}%2~%F{blue}]%f%# '


dist=$(cat /etc/os-release | grep ^ID | sed -e "s/^ID=\(.*\)/\1/")

case $dist in
	debian)
		#do deb
		alias nvim=nvim.appimage
		;;
	arch)
		#do arch
		;;
esac

alias vim=nvim
alias vi=nvim
alias sudo='sudo '
alias sudol='sudo !!'
alias ls='ls --color=auto'
alias cd4share='cd /media/Disk4T/share'
alias devtools='cd /opt/dev/c/dev_tools'
alias goDir='cd /mnt/c/Users/arjevn/go'
alias devPS301FHB='cd /mnt/c/Arendal/Hitachi/PS301F-Halfbridge/5\ Kitron\ SW'
alias tf=TF.exe
alias fcd='cd $(find * -type d | fzf)'
export GO111MODULE=on
export GOPRIVATE=github.com/krngla
#export GOPATH=/mnt/c/Users/arjevn/go

for FILE in ~/zshrc/*; do
	source $FILE
done

mkcd () {
	mkdir -p "${1}"
	cd "${1}"
}
