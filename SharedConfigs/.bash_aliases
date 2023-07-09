# The most frequently used commands from my bash history get abbreviation aliases

# TODO do some more research on the web wrt. what could be added here
# TODO do sth. similar in Windows cmd and Windows PowerShell?
# TODO add alias for git switch

# 1-3 letter aliases
# free one letter aliases(9): ijknoquwy
alias a='git add'
alias A='git add --all'
alias a.='git add .'
alias b='git branch'
alias c='git commit --verbose'
alias ca='git commit --amend --no-edit'
alias ch='git checkout'
alias d='git diff'
alias e='echo'
alias f='find'
alias g='git'
alias gl='git log --stat'
alias glo='git log --oneline --decorate --color'
alias gc='git clone'
alias gg='git grep'
alias h='history'
alias l='ls -CF'
alias L='ls -A'
alias ll='ls -alF'
alias m='man'
alias ph='git push'
alias pl='git pull'
alias py='python3'
alias r='git reset'
alias r.='git reset HEAD~1'
alias r..='git reset HEAD~2'
alias s='git status'
# alias ss='git status --short' todo conflict on Ubuntu
alias sph='git stash push'
alias spo='git stash pop'
alias t='cat'
alias v='nvim'
alias x='cd ~/x/' # all my development repos go here

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../.. && pwd'
alias ....='cd ../../../.. && pwd'
alias .....='cd ../../../../.. && pwd'
alias cd1='cd ..'
alias cd2='cd ../.. && pwd'
alias cd3='cd ../../.. && pwd'
alias cd4='cd ../../../.. && pwd'
alias cd5='cd ../../../../.. && pwd'
alias cd6='cd ../../../../../.. && pwd'
alias cd7='cd ../../../../../../.. && pwd'
alias cd8='cd ../../../../../../../.. && pwd'
alias cd9='cd ../../../../../../../../.. && pwd'

# 3+ letter aliases
alias open="xdg-open"

# "repeat" command.  Like:
#
#	repeat 10 echo foo
repeat ()
{ 
    local count="$1" i;
    shift;
    for i in $(seq 1 "$count");
    do
        eval "$@";
    done
}

# Subfunction needed by `repeat'.
seq ()
{ 
    local lower upper output;
    lower=$1 upper=$2;

    if [ $lower -ge $upper ]; then return; fi
    while [ $lower -le $upper ];
    do
	echo -n "$lower "
        lower=$(($lower + 1))
    done
    echo "$lower"
}

# Unused commands:
# alias gr='git review' # a Gerrit thing
# alias d='git review -d'
