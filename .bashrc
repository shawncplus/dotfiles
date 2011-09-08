# .bashrc
export EDITOR="vim"

for i in ~/completion/*; do
	. $i
done

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# custom functions
if [ -f /home/${USER}/.bash/functions ]; then
	. /home/${USER}/.bash/functions
fi

# custom functions
if [ -f /home/${USER}/.bash/aliases ]; then
	. /home/${USER}/.bash/aliases
fi

export PATH=$PATH":/home/${USER}/bin/"

# Ye olde prompt
#uses gitprompt.pl (github.com/mikecanz/env)
#export PS0='\[[38;5;202m\]\u\[[37m\] in \[[38;5;107m\]\w\[[37m\] on \[[38;5;1m\]\h\[[37m\]%{ at \[\e[38;5;25m\]%b%c%u%f%t %} \e[0m'
#export PROMPT_COMMAND='export PS1=$(gitprompt.pl c=%[%e[34m u=%[%e[33m f=%[%e[38\;5\;15m statuscount=1)'
export PS0='\[[38;5;202m\]\u\[[37m\] in \[[38;5;107m\]\w\[[37m\] on \[[38;5;1m\]\h\[[37m\]%{ at \[\e[38;5;25m\]%b%c%u%f%t\[\e[0m\]%} - '
export PROMPT_COMMAND=$PROMPT_COMMAND';export PS1=$(gitprompt.pl c=%[%e[38\;5\;10m u=%[%e[33m f=%[%e[38\;5\;15m statuscount=1)'

cd `cat ~/.prev_dir`
cat /dev/null > ~/.prev_dir

LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ex=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:"
