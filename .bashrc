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

export PATH=$PATH":/home/$USER/bin/:/home/$USER/.local/bin"

dash_color='\[[38;5;178m[1m\]'
base_color='\[[38;5;24m\]'
stripe_one_col='\[[48;5;0m[38;5;30m[1m\]'
stripe_two_col='\[[48;5;0m[38;5;36m[1m\]'
end_stripe_col='\[[48;5;0m[38;5;42m[1m\]'

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
POWERLINE_NO_SHELL_ABOVE=1
. ~/repos/powerline/powerline/bindings/bash/powerline.sh

cd `cat ~/.prev_dir`
cat /dev/null > ~/.prev_dir

eval "$(dircolors ~/.bash/.DIR_COLORS)"

TERM=xterm-256color

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
