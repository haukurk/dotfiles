#
# Haukur Kristinsson haukur@hauxi.is 
# Linux Bash Profile.
#

# Go Workspace configuration
export GOROOT=/usr/local/go
export GOPATH=$HOME/workspace-go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Functions
apply_current_ssh_key()
{
  if [ -z "$1" ]
    then
      echo "You have to specify a ssh connection string."
  fi
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys
  ssh $1 "cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_rsa.pub
}

apply_ssh_key_haukur_default()
{
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys
  curl -s http://www.hauxi.is/security/id_rsa.pub -w "\n" >> ~/.ssh/authorized_keys
  unset apply_ssh_key_haukur_default
}

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  c_reset=`tput sgr0`
  c_user=`tput setaf 2; tput bold`
  c_path=`tput setaf 4; tput bold`
  c_git_clean=`tput setaf 2`
  c_git_dirty=`tput setaf 1`
else
  c_reset=
  c_user=
  c_path=
  c_git_cleanclean=
  c_git_dirty=
fi

# Function to assemble the Git parsingart of our prompt.
git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

  if git diff --quiet 2>/dev/null >&2; then
    git_color="$c_git_clean"
  else
    git_color="$c_git_dirty"
  fi

  echo "[$git_color$git_branch${c_reset}]"
}

#
# Shell options
shopt -s histappend
set +o histexpand     # enable strings with !

#
# Env variables
export HISTSIZE=100000
export HISTFILESIZE=409600
export HISTIGNORE="cd:ls:[bf]g:clear:exit:gp:gs:ll"
export HISTCONTROL=ignoredups

# Aliases
. ~/.aliases

# Tab completion for ssh hosts, from known_hosts. I love this.
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

# this prompt will show the hostname in green if the last command returned 0,
# otherwise it will be red.
#PS1="\[\`if [[ \$? = "0" ]]; then echo '\e[32m\h\e[0m'; else echo '\e[31m\h\e[0m' ; fi\`:\w\n\$"

#Prompt and prompt colors
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold
function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  #export PS1="\n$BLACKBOLD[\t]$GREENBOLD \u@\h\[\033[00m\]:$BLUEBOLD\w\[\033[00m\] \\$ "
  export PS1="$WHITE[\$(date +"%T")] $WHITEBOLD(\u@\h:\w) \$(git_prompt)> "
}
prompt

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# If not running interactively, don't do anything
if [[ $- != *i* ]]; then return; else occasions; fi     

# EOF
