# 1-3 letter aliases
# free one letter aliases(9): ijknoquwy
# TODO update to match .bash_aliases

function a { & git add $args }
function a. { & git add . $args }
function aa { & git add --all $args } # 'A' on Unix
function b { & git branch $args }
function c { & git commit --verbose $args }
function ca { & git commit --amend --no-edit $args }
function ch { & git checkout $args }
function d { & git diff $args }
New-Alias -Name e -Value echo
# function f {find}
function g { & git $args }
function gl { & git log --stat $args }
function glo { & git log --oneline --decorate --color $args }
function gc { & git clone $args }
function gg { & git grep $args }
# function l { & Get-ChildItem -CF $args }
# function L { & Get-ChildItem -A $args }
# function ll { & Get-ChildItem -alF $args }
function m { & help $args }
function ph { & git push $args }
function pl { & git pull $args }

# function py {python3} - this already exists on Windows
# function r {git reset}  - already exists in Powershell as some other command TODO
function r. { & git reset $args HEAD~1 }
function r.. { & git reset $args HEAD~2 }
function s { & git status $args }
# function ss { & git status --short $args } - todo conflict on Ubuntu
function sph { & git stash push $args }
function spo { & git stash pop $args }
New-Alias -Name t -Value cat
New-Alias -Name v -Value nvim
function x {Set-Location ~/x/} # all my development repos go here


# alias cd..='cd ..' - already exists in PowerShell
function .. { Set-Location .. }
function ... { Set-Location ../../.. }
function .... { Set-Location ../../../.. }
function ..... { Set-Location ../../../../.. }

function cd1 { Set-Location .. }
function cd2 { Set-Location ../.. }
function cd3 { Set-Location ../../.. }
function cd4 { Set-Location ../../../.. }
function cd5 { Set-Location ../../../../.. }
function cd6 { Set-Location ../../../../../.. }
function cd7 { Set-Location ../../../../../../.. }
function cd8 { Set-Location ../../../../../../../.. }
function cd9 { Set-Location ../../../../../../../../.. }

# TODO READ
# Liniks:
# https://stackoverflow.com/questions/55539278/is-there-a-way-to-create-an-alias-to-a-cmdlet-in-a-way-that-it-only-runs-if-argu/55539863#55539863
# https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3
# https://stackoverflow.com/questions/63291583/powershell-whats-the-difference-between-alias-and-function
# https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.3#parameters
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.3
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases?view=powershell-7.3
# https://stackoverflow.com/questions/24914589/how-to-create-permanent-powershell-aliases
