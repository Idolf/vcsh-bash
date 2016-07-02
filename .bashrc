# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# history
HISTCONTROL=ignoreboth
HISTFILESIZE=50000
HISTSIZE=50000

# options
shopt -s cdspell
shopt -s globstar
shopt -s histappend
shopt -s checkwinsize
shopt -u mailwarn
unset MAILCHECK

# colors
# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

PS1='$(git branch &>/dev/null;\
# in a git repo
if [ $? -eq 0 ]; then \
    n=$(git stash list --no-color 2>/dev/null | wc -l | tr -d "\\n") ; \
    if [ "$n" -ne "0" ] ; then \
        echo -ne "\[${BRed}\]${n}\[${NC}\]:" ; \
    fi ; \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # Clean repository - nothing to commit
    echo $(__git_ps1 "\[${Green}\]%s\[${NC}\]"); \
  else \
    # Changes to working tree
    echo $(__git_ps1 "\[${Red}\]%s\[${NC}\]"); \
  fi):"; \
# not in a git repo
else \
  echo ""; \
fi)'

if [[ ${USER} == "root" ]]; then
   PS1="${PS1}\[${Yellow}\]\h\[${NC}\]:\[${ALERT}\]\w\[${NC}\]"
else
   if [ -n "${SSH_CONNECTION}" ]; then
      PS1="${PS1}\[${Yellow}\]\h\[${NC}\]:"
   fi
   PS1="${PS1}\[${BBlue}\]\w\[${NC}\]"
fi

PS1="${PS1}> "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# "aliases"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mtr='mtr -t'
alias mkdir='mkdir -pv'
function mkdircd () { mkdir -pv "$@" && eval cd "\"\$$#\""; }
alias gdb='gdb -q -n -x ~/.gdbinit'
alias strings='strings -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ipython='ipython --no-banner'
alias gcc='gcc -Wall -Wextra -pedantic -O3'
alias mosml='rlwrap mosml -P full'
alias pps='ps --ppid 2 -p 2 --deselect hfw'
alias dmesg='dmesg -xe'
alias zathura='zathura --fork'

function emacs () {
    (/usr/bin/env emacs --no-splash $@ </dev/null >/dev/null 2>/dev/null &)
}

source /usr/share/autojump/autojump.bash

[ -f ~/.environment ] && . ~/.environment
if [ -f ~/gcloud/google-cloud-sdk/completion.bash.inc ]; then
  source ~/gcloud/google-cloud-sdk/completion.bash.inc
fi
