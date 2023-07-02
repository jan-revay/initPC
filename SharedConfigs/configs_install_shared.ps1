# !! This script must be compatible with PowerShell and also with Bash !!

mkdir ~/books
mkdir ~/x # all my development repos go here
mkdir ~/x/tmp # stuff that can be deleted after restart

git config --global core.editor "nvim"
git config --global user.name "JohnnyRevay"
# TODO make the email a bit more SPAM resistant as it is in a public repo...
git config --global user.email "jan.revay.tutor@gmail.com"
git config --list --show-origin
