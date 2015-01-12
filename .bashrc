# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. /opt/bash-completion/etc/profile.d/bash_completion.sh

[ -f ~/bin/git-prompt.sh ] && . ~/bin/git-prompt.sh

# append to the history file, don't overwrite it
shopt -s histappend
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTFILE=$HOME/.bash_history2

# Ignore duplicates and spaces in front of a command
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s cdspell
shopt -s globstar
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

# Main prompt
PS1="\[\033[01;32m\]\u@\h:\[\033[01;34m\]\w\$\[\033[00m\] "

PS1='$(git branch &>/dev/null;\
# in a git repo
if [ $? -eq 0 ]; then \
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

alias ls='colorls -G'
#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias gdb='gdb -q -n -x ~/.gdbinit'
alias mtr='mtr -t'
alias strings='strings -a'
#alias netstat='netstat -46p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ipython='ipython --no-banner'
alias gcc='gcc -Wall -Wextra -pedantic -O3'
alias mosml='rlwrap mosml -P full'
alias cal='cal -m'

function emacs () {
  (/usr/bin/emacs -D $@ </dev/null >/dev/null 2>/dev/null &)
}

export MANSECT="2,3,1,4,5,6,7,8,9"
export PAGER=less
export EDITOR=vim

if [ -d $HOME/.cabal/bin ]; then
  export PATH=$HOME/.cabal/bin:$PATH
fi

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH
fi

for d in /opt/*/bin; do
  export PATH=$PATH:$d
done
