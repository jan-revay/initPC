# initPC

🛠A collection of C++, Python & Rust development-oriented config scripts to quickly init new machines for my personal use.💻Dotfiles are in a separate repository here: <https://github.com/jan-revay/dotfiles> and here: <https://github.com/jan-revay/windows_dotfiles>

## How to use

### On Linux

1. `cd ~`
2. `git clone https://github.com/jan-revay/initPC.git`
3. `cd initPC/`
4. `git checkout <branch>` (optional, default is the branch `devel`)
5. `./run_init.sh` (a platform-independent init script launcher)

Note: Logs will appear in the folder `initPC/Logs/`. Use `cat <logfile>` to display a log file with the original VT100 colors.

After you updated the `initPC` or `dotfiles` repo (e.g. adding a package, changing a config file, or adding an alias...), run the `refresh` command from Bash to apply the config change to your machine.

### On Windows

1. `cd ~`
2. `git clone https://github.com/jan-revay/initPC.git`
3. `cd initPC`
4. `git checkout <branch>` (optional, default is the branch `devel`)
5. `cd Windows_10`
6. `.\run_all.ps1`

## Branches

1. **minimal** - debloated, stable, tested, production-ready, and not expected to change in the _yearly horizon_. Only necessary stuff. Possibly useful for detecting whether bugs in the stable branch are caused by the init script or to be used as a substitute for the stable branch while the stable branch has a critical bug.
2. **stable** - stable, tested, production-ready, and not expected to change much in the _monthly horizon_.
3. **testing** - shouldn't be broken or inconsistent most of the time, useful changes from devel that are queued to be accepted to stable (or rejected).
4. **devel** - development and experiments, might be inconsistent or broken regularly. Useful, consistent, and fully functional changes from the branch devel might be merged into the branch testing.

Minimal, stable, and testing branches are expected to be _always in a consistent state_ so that they can always be used to init a machine e.g. VM or a bootable partition. The devel branch is expected to be broken from time to time (e.g. when working on larger changes "per partes") and it might not always be possible to init a machine using it.

### Workflow

```text
               functional &           tested &
  impl.         consistent             useful            necessary
O------> devel -------------> testing ---------> stable -----------> minimal
```

### Feature branch naming scheme

All feature branches should be branched off and merged to devel (only devel itself
can be merged into the branch testing). Names of feature branches must match the
following:

```
devel-feature-<name of the feature>
```

## FAQ

### 1. Why don't I use Ansible?

TODO

### 3. Why don't I use Chezmoi?

TODO

## TODO

1. Merge and deprecate the InitNewPC repo InitPC repo on org GitHub and initAndroid repo.
2. Merge with LogidCfg repo
3. Test the Windows setup script on a VM
4. Create aliases for PowerShell
5. Try merging the apt, flatpak, and snap install commands
6. Have a look at popOS packages and add the useful ones to other init scripts
7. Design a system for applying the configs on all my machines once they
   were updated here.
   - implement `refresh` alias
   - add notification to .bashrc if the initPC or dotfiles are not up to date
9. Add more C++ tools from here: <https://github.com/cpp-best-practices/cppbestpractices/blob/master/02-Use_the_Tools_Available.md>
10. Add Bats automated tests
11. Try adding NixOS
12. Create CI tests on GitHub
13. Todos from the repo
14. Make the core Linux init script Debian based (i.e. other distros just add stuff to the Debian base init script)
15. Maybe replace the Debian variants (Ubuntu, PopOS...) with a single Ansible script with conditionals?
16. Do some research on whether snap and flatpak packages work in WSL resp. which alternative package manager to use in WSL
17. Consider running the whole `./run_all.sh` script as sudo and removing `sudo` commands from the script.
18. Shorten the names of branches I use most often devel -> dev, testing -> test
19. Consider using <http://www.bashbooster.net/>, <https://github.com/bevry/dorothy>, <https://www.chezmoi.io/> or similar libraries (see: <https://www.chezmoi.io/comparison-table/> and <https://dotfiles.github.io/utilities/>).
20. Format to max 82 chars in a line.
21. Echo errors to stderr
22. Make the script compliant with Google Bash style guide.
23. Consider running different files in different subshells i.e. not using `source` command.
