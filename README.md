# initPC

I use this collection of scripts to init all machines I use. The setup is C++ development oriented.

## How to use

1. `git clone https://github.com/jan-revay/initPC.git`
2. run `./\<Platform\>/run_all.sh` script e.g. `WSL_Ubuntu_22.04/run_all.sh` where `<Platform>` is the host OS/platform

## TODO

1. Merge and deprecate the InitNewPC repo InitPC repo on org github and initAndroid repo.
2. Merge with LogidCfg repo
3. Test the Windows setup script on a VM
4. Create aliases for PowerShell
5. Try merging the apt, flatpak and snap install commands
6. Have a look at popOS packages and add the useful ones to other init scripts
7. Design a system for applying the configs on all my machines once they
   were updated here.
8. Add more C++ tools from here: https://github.com/cpp-best-practices/cppbestpractices/blob/master/02-Use_the_Tools_Available.md
9. Add Bats automated tests
10. Try adding NixOS
11. Create CI tests on GitHub
12. Use this Docker container as an inspiration https://github.com/cpp-best-practices/cmake_template/blob/main/.devcontainer/Dockerfile

## Similar repos

- https://github.com/shubham-goel/init-linux
- https://ae.prasadt.com/ (https://github.com/tprasadtp/ubuntu-post-install)
