# initPC

🛠A collection of C++, Python & Rust development-oriented config scripts to quickly init new machines for my personal use.💻Dotfiles are in a separate repository here: <https://github.com/jan-revay/dotfiles> and here: <https://github.com/jan-revay/windows_dotfiles>

## How to use

1. `cd ~`
2. `git clone https://github.com/jan-revay/initPC.git`
3. `cd initPC/`
4. `git checkout <branch>` (optional step, branch `devel` is the default)
5. Run the initPC script launcher:
    * `./run_init.sh` - on Linux distros or Termux
    * `cd Windows_10 && .\run_all.ps1` - on Windows

✔️ *Note: Logs will appear in the folder `initPC/Logs/`. Use `cat <logfile>` to display the log file with the original VT100 colors.*

After you updated the `initPC` or `dotfiles` repo (e.g. adding a package, changing a config file, or adding an alias...), run the `refresh` command from Bash to apply the config change to your machine.

## Branches

1. **`LTS`** - debloated, stable, tested, production-ready, and not expected to change in the _yearly horizon_. Only necessary stuff. Possibly useful for detecting whether bugs in the stable branch are caused by the init script or to be used as a substitute for the stable branch while the stable branch has a critical bug. Debloating is done via additional commits on top of the `LTS` branch, therefore syncing `stable` and `LTS` is done via rebasing to preserve the debloating commits on top.
2. **`stable`** - stable, tested, production-ready, and not expected to change much in the _monthly horizon_.
3. **`testing`** - shouldn't be broken or inconsistent most of the time, useful changes from `devel` that are queued to be accepted to the `stable` branch (or rejected). If a change is rejected from `testing` it will be dropped via a commit in `devel` that will be fast-forward merged to the `testing` branch again.
4. **`devel`** - development and experiments, might be inconsistent or broken regularly. Useful, consistent, and fully functional changes from the branch devel might be merged into the branch `testing`.
5. **`feature-<name of the feature>`** - all feature branches should be branched off and merged to devel. Features and bugfixes of `testing`, `stable` or `LTS` should always go through the `devel` branch first (following the change workflow below).
6. **`archived/<branch-name>-<YYYY-MM-DD>`** - branches archived before a `push --force`.

`LTS`, `stable`, and `testing` branches are expected to be _always in a consistent state_ so that they can always be used to init a new machine e.g. VM or a bootable partition. The `devel` branch is expected to be broken from time to time (e.g. when working on larger changes "per partes" or experimenting) and it might not always be possible to init a machine using it. Changes are usually pushed to the `devel` branch directly, very large changes can have an individual feature branch however.

✔️ *Note: By stable I mean free of an unpredictable behavior and crashes, not as decribed here: https://medium.com/@gordon.messmer/what-does-stable-mean-4447ac53bac8 (TODO toread)*

### Change workflow

```text
               functional &              tested &        not changing, debloated
  impl.         consistent                useful           stable & necessary
O------> devel -------------> testing -------------> stable -------------> LTS
               ff-only merge          ff-only merge            rebase
```

## FAQ

### 1. Why don't I use Ansible?

TODO

### 2. Why don't I use Chezmoi?

TODO

### 3. Is the `refresh` command idempotent?

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
24. shared_gui_packages_install.sh
25. Automatic formatting of markdown files
26. Format markdown files (add linebreaks, beautify...)
27. Consolidate branches (unmerged feature branches).
28. Backup solution
