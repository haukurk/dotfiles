#
# Haukur Kristinsson haukur@hauxi.is 
# Linux Bash Profile.
#

#
#  OS Related Aliases #
alias ll="ls -lhFG --color=auto"
alias ls="ls -FG --color=auto"
alias dir="ll"

alias gemlist='gem list | egrep -v "^( |$)"'

alias mbp='mate ~/.bash_profile'
alias sbp='source ~/.bash_profile'

alias gb='git branch'
alias gba='git branch -a'
alias gcav='git commit -av'
alias gca='git commit -a'
alias gd='git diff'
alias gl='git pull origin master'
alias gp='git push origin master'
alias gp?='git log --pretty=oneline origin/master..HEAD'
alias gs='git status'
alias gpcd='git push origin master && cap deploy'
alias gpom='git pull origin master'
alias git='hub'

#
# Functions
apply_ssh_key()
{
  ssh $1 "cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_rsa.pub
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

# Tab completion for ssh hosts, from known_hosts. I love this.
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

# this prompt will show the hostname in green if the last command returned 0,
# otherwise it will be red.
#PS1="\[\`if [[ \$? = "0" ]]; then echo '\e[32m\h\e[0m'; else echo '\e[31m\h\e[0m' ; fi\`:\w\n\$"
# My classic one.
PS1="(\d \t) (\u@\h:\w)\nbash> "
export PS1

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# EOF