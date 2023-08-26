# initPC

A collection of (C++, Python & Rust development-oriented) config scripts to quickly init new machines for my personal use. Dotfiles are in a separate repository here: <https://github.com/jan-revay/dotfiles>.

## How to use

1. `git clone https://github.com/jan-revay/initPC.git`
2. `cd initPC/`
3. `mkdir Logs`
4. `cd ./<Platform>/` for example `cd ./WSL_Ubuntu_22.04/`
5. `./run_all.sh 2>&1 | tee ../Logs/$(date "+%Y%m%d_%H%M%S").log`

Note: `cat <logfile>` will display the log with the original VT100 colors.

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

#### Feature branch naming scheme

All feature branches should be branched off and merged to devel (only devel itself
can be merged into the branch testing). Names of feature branches must match the
following:

```
devel-feature-<name of the feature>
```

Using a different naming scheme will break ./install_dotfiles.sh script.

## Installing pre-commit hooks

To install pre-commit hooks run:

```
cd ./initPC/.git/hooks/
ln -s ../../pre-commit-hook.sh pre-commit
```

The pre-commit hook currently runs `shfmt` and `shellcheck`

## TODO

1. Merge and deprecate the InitNewPC repo InitPC repo on org GitHub and initAndroid repo.
2. Merge with LogidCfg repo
3. Test the Windows setup script on a VM
4. Create aliases for PowerShell
5. Try merging the apt, flatpak, and snap install commands
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
15. Do some research on whether snap and flatpak packages work in WSL resp. which alternative package manager to use in WSL
16. Consider running the whole `./run_all.sh` script as sudo and removing `sudo` commands from the script.
17. Shorten the names of branches I use most often devel -> dev, testing -> test
