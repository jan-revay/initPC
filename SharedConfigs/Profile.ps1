# 1-3 letter aliases
# free one letter aliases(9): ijknoquwy
# function a {git add}
function a. {git add .}
# function b {git branch}
function c {git commit}
function ca {git commit --amend --no-edit}
# function ch {git checkout}
function d {git diff}
# function e {echo}
# function f {find}
function gl {git log}
# function gc {git clone}
# function gg {git grep}
# function h {history} - already exists
# function l {ls -CF}
# function L {ls -A}
# function ll {ls -alF}
# function m {help}
function ph {git push}
function pl {git pull}
# function py {python3}
# function r {git reset}  - already exists
function r. {git reset HEAD~1}
function r.. {git reset HEAD~2}
function s {git status}
function sph {git stash push}
function spo {git stash pop}
# function t {cat}
New-Alias -Name v -Value nvim
function x {Set-Location ~/x/} # all my development repos go here


# Set-Alias -Name a -Value a
# Set-Alias -Name b -Value b
# Set-Alias -Name c -Value c
# Set-Alias -Name d -Value d
# Set-Alias -Name e -Value e
# Set-Alias -Name f -Value f
# Set-Alias -Name g -Value g
# Set-Alias -Name h -Value h
# Set-Alias -Name i -Value i
# Set-Alias -Name j -Value j
# Set-Alias -Name k -Value k
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a
# Set-Alias -Name a -Value a

# TODO
# Liniks:
# https://stackoverflow.com/questions/55539278/is-there-a-way-to-create-an-alias-to-a-cmdlet-in-a-way-that-it-only-runs-if-argu/55539863#55539863
# https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3
# https://stackoverflow.com/questions/63291583/powershell-whats-the-difference-between-alias-and-function
# https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.3#parameters
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.3
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases?view=powershell-7.3
# https://stackoverflow.com/questions/24914589/how-to-create-permanent-powershell-aliases
