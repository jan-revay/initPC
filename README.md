# initPC (WIP)

A collection of (C++ development-oriented) scripts and configuration files (dotfiles) to quickly init new machines for my personal use.

## How to use

1. `git clone https://github.com/jan-revay/initPC.git`
2. `cd initPC/<Platform>/` for example `cd initPC/WSL_Ubuntu_22.04/`
3. `./run_all.sh`

## Branches

1. **minimal** - debloated, stable, tested, production-ready, and not expected to change in the *yearly horizon*, only necessary stuff
2. **stable** - stable, tested, production-ready, and not expected to change much in the *monthly horizon*
3. **testing** - shouldn't be broken or inconsistent most of the time, useful changes from devel that are queued to be accepted to stable (or rejected)
4. **devel** - development and experiments, might be inconsistent or broken regularly. Useful, consistent, and fully functional changes from the branch devel might be merged into the branch testing.

#### Workflow:
```
        implementation          useful & functional           tested & useful           necessary
Change ----------------> devel --------------------> testing -----------------> stable -----------> minimal
```

## TODO

1. Merge and deprecate the InitNewPC repo InitPC repo on org github and initAndroid repo.
2. Merge with LogidCfg repo
3. Test the Windows setup script on a VM
4. Create aliases for PowerShell
5. Try merging the apt, flatpak and snap install commands
6. Have a look at popOS packages and add the useful ones to other init scripts
7. Design a system for applying the configs on all my machines once they
   were updated here.
8. Add more C++ tools from here: <https://github.com/cpp-best-practices/cppbestpractices/blob/master/02-Use_the_Tools_Available.md>
9. Add Bats automated tests
10. Try adding NixOS
11. Create CI tests on GitHub
12. Todos from the repo
13. Make the core Linux init script Debian based (i.e. other distros just add stuff to the Debian base init script)
14. Maybe replace the Debian variants (Ubuntu, PopOS...) with a single Ansible script with conditionals?
15. Do some research whether snap and flatpak packages work in WSL resp. which alternative package manager to use in WSL
16. Init script is now broken for Debian because of PPAs!!!
