# The most frequently used commands from my bash history get abbreviation aliases

# TODO do some more research on the web wrt. what could be added here
# TODO do sth. similar in Windows cmd and Windows PowerShell?
# TODO add alias for git switch
# TODO think about commands that could use a capitalized version

# Enable aliases to be sudo’ed
alias sudo='sudo '

alias update='sudo apt update && sudo apt upgrade'
alias path='echo -e ${PATH//:/\\n}'

# 1-3 letter aliases
# free one letter aliases(9): ijknoquwy
alias a='git add'
alias A='git add --all'
alias aa='git add --all'
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
alias l='exa -F' # TODO - set/learn ls colors
alias L='exa -aF'
alias ll='exa -alF'
alias lsd='exa -DF'
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
alias t='batcat'
alias v='nvim'

# alias dl="cd ~/Downloads"
alias x='cd ~/x/' # all my development repos go here
alias -- -='cd -' # without '--' -= would be interpretted as a CLI flag
alias cd..='cd ..'
# I use the ',' character instead of dots because `.` is already taken in UNIX
# and I want the number of nested direcotires to math the number of dots/commas.
alias ,='cd ..'
alias ,,='cd ../.. && pwd'
alias ,,,='cd ../../.. && pwd'
alias ,,,,='cd ../../../.. && pwd'
alias ,,,,,='cd ../../../../.. && pwd'
alias 1='cd .. && pwd'
alias 2='cd ../.. && pwd'
alias 3='cd ../../.. && pwd'
alias 4='cd ../../../.. && pwd'
alias 5='cd ../../../../.. && pwd'
alias 6='cd ../../../../../.. && pwd'
alias 7='cd ../../../../../../.. && pwd'
alias 8='cd ../../../../../../../.. && pwd'
alias 9='cd ../../../../../../../../.. && pwd'

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
