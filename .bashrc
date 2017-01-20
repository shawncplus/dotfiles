# .bashrc
export EDITOR="vim"

set -o vi

for i in ~/completion/*; do
	. $i
done

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# custom functions
if [ -f /home/$USER/.bash/functions ]; then
	. /home/$USER/.bash/functions
fi

# custom functions
if [ -f /home/$USER/.bash/aliases ]; then
	. /home/$USER/.bash/aliases
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -d "$HOME/repos/dev-scripts" ]; then
    PATH=$PATH:$HOME/repos/dev-scripts
fi

export PATH=$PATH":/home/$USER/bin/:/home/$USER/.local/bin:$GOPATH/bin:$HOME/repos/node-v4.2.2-linux-x64/bin"
export HISTSIZE=9999
export HISTFILESIZE=9999
export GOPATH=$HOME

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
POWERLINE_NO_SHELL_ABOVE=1
. ~/repos/powerline/powerline/bindings/bash/powerline.sh

cd `cat ~/.prev_dir`
cat /dev/null > ~/.prev_dir

eval "$(dircolors ~/.bash/.DIR_COLORS)"
eval "$(direnv hook bash)"

export TERM=xterm-256color-italic

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
