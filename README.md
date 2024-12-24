# initPC

🛠 A collection of C++, Python & Rust development-oriented config
scripts to quickly init new machines 💻 for my personal use. Dotfiles
are in a separate repository here:
<https://github.com/jan-revay/dotfiles> and here:
<https://github.com/jan-revay/windows_dotfiles>

## How to use

### First run on a new machine

1. `cd ~`
2. `git clone https://github.com/jan-revay/initPC.git`
3. `cd initPC/`
4. `git checkout <branch>` (optional step, branch `devel` is the
   default)
5. Run the initPC script launcher:
    * `./run_init.sh` - on Linux distros or Termux
    * `Set-ExecutionPolicy unrestricted && cd Windows_10 &&
      .\run_all.ps1` - on Windows (with administrator privileges)

✔️ *Note: Logs will appear in the folder `initPC/Logs/`. Use `cat
<logfile>` to display the log file with the original VT100 colors.*

### Applying changes in this repo to your machine

If you have updated the `initPC` or `dotfiles` repo, use the:

```bash
refresh
```

command (an alias defined in `.bash_aliases`) to apply the changes in
the repository to your machine (e.g. install added packages). Keep in
mind, that the `refresh` script only adds stuff, it never removes any
packages (other than `apt-get autoremove`) even if those were removed
from the initPC repo and it does not reverse already executed changes in
the machine configuration (the Nix config will be able to do that, but
it is not finished). Removing a package/config option from the initPC
script does not affect the configuration of the existing machine after
the script is executed for the first time. The `refresh` script however
overwrites the old configuration options with new ones, if a particular
config option was modified (e.g. a gsettings option).

## OSes and distributions

Currently, the main focus of the initPC script is a well-tuned **Ubuntu
24.04 with GNOME resp. CLI, and Windows 11**. Some other Debian-based
distros are also supported to various degrees, but initPC scripts for
other OSes/distros are not maintained as much & the support for them
might be completely dropped in the future.

## FAQ

### 1. Is the `refresh` command idempotent?

**Yes**, the refresh command should be idempotent. This is also partly
verified in CI via GitHub actions (TODO make sure and improve the test).

By *idempotency*, we mean:

```text
Let:
R_C1 - executing refresh resp. initPC via ./run_init.sh on a commit C1
𝓢 - set of all possible states of an OS image
S ∈ 𝓢 - clean state (state after installing a new OS before running ./run_init.sh)
∘ : R_Ci x 𝓢 -> 𝓢 - application of the `refresh` command to the state of the machine

We want:

R_C1 ∘ (R_C1 ∘ S) = R_C1 ∘ S
```

<h3> 2. Does the <code>refresh</code> command (on a machine in any state) always
   produce the same state as running the script on a clean new OS install
   from scratch? Why not use Nix?</h3>

In general **no**. Only the Nix package manager can do rollbacks and
updates (e.g. removing packages and configs) deterministically. It would
be hard to replicate that elsewhere. However, the whole configuration of
a new machine takes just around 20 minutes with the Ubuntu initPC
scripts. Therefore if the state of an existing machine and the state
described in this repo do diverge too much, it should be possible to
reinstall the OS and reconfigure the machine from a clean state fairly
quickly (TODO after the backup solution is also finished). Hence despite
NixOS being more capable in this regard, it is still possible to achieve
a similar practical effect using this init script. As Nix is not as
widely used as Debian and Ubuntu, I have used Debian package manager as
a default rather than Nix. However, I plan to implement the initPC
script for Nix as well and I am also considering using Nix more in the
future, for now, however, most effort is spent on tuning the Ubuntu
version of the setup script.

By *deterministic system configuration*, we mean:

```text
Let us have 2 commits:
C1 -> C2

And let:
R_Ci - executing refresh resp. initPC via ./run_init.sh on a commit Ci
𝓢 - set of all possible states of an OS image
S ∈ 𝓢 - clean state (state after installing a new OS before running ./run_init.sh)
∘ : R_Ci x 𝓢 -> 𝓢 - application of the `refresh` command to the state of the machine

We want:

R_C2 ∘ (R_C1 ∘ S) = R_C2 ∘ S
```

### 3. Why don't I use Ansible?

At the moment it would just add complexity, and unnecessary dependence
(e.g. it could break Termux on Android), be less flexible, and would not
be as beneficial for a project of this size. Also, I don't have any
experience in writing Ansible scripts... However, I might rewrite some
parts of the codebase to Ansible scripts later.

### 4. Why don't I use Chezmoi?

Dotfiles are currently managed via a bare Git repo (home directory) and
Stow (system-level configuration files). In the future, I might use
Chezmoi or a more sophisticated tool for managing dotfiles & templating
them, if the need arises. See: <https://www.chezmoi.io/why-use-chezmoi/>

## Branches

1. **`devel`** - development and experiments, might be inconsistent or
   broken regularly. Consistent, and fully functional changes from the
   branch `devel` might be merged into the branch `testing`. The `devel`
   branch is expected to be broken from time to time (e.g. when working
   on larger changes "per partes" or experimenting) and it might not
   always be possible to init a machine using it. New changes are
   usually pushed to the `devel` branch directly, however, very large
   changes can have an individual feature branch.
2. **`testing`** - shouldn't be broken or inconsistent most of the time.
   This branch has changes from `devel` queued to be accepted to the
   `stable` branch (or rejected). If a change is rejected from `testing`
   it will be dropped via a commit into `devel` that will be
   fast-forward merged to the `testing` branch again.
3. **`stable`** - tested, stable, useful, production-ready, and not
   expected to change more than a few times a year.
4. **`LTS`** - debloated, (also tested, stable, useful,
   production-ready) and not expected to change much in the *yearly
   horizon*. Only necessary stuff. Possibly useful for detecting whether
   bugs in the `stable` branch are caused by the init script or to be
   used as a substitute for the `stable` branch while the `stable`
   branch has a critical bug. Debloating is done via additional commits
   on top of the `LTS` branch, therefore syncing `stable` and `LTS` is
   done via rebasing to preserve the debloating commits on top. As the
   `LTS` branch has additional commits on top, it is tested separately.
5. **`feature-<name of the feature>`** - all feature branches should be
   branched off and merged to `devel`. Features and bugfixes of
   `testing`, `stable`, or `LTS` should always go through the `devel`
   branch first (following the change workflow below).
6. **`archived/<branch-name>-<YYYY-MM-DD>`** - branches archived before
   a `push --force`.

`LTS`, `stable`, and `testing` branches are expected to be *always in a
consistent state* so that they can always be used to init a new machine
e.g. VM or a bootable partition.

✔️ *Note: By stable I mean free of unpredictable behavior and crashes,
not as described here:
<https://medium.com/@gordon.messmer/what-does-stable-mean-4447ac53bac8>
(TODO toread)*

### Change workflow

```text
                    functional &         tested, stable, useful   not changing, debloated,
    impl.            consistent**          & production-ready        retested & stable
O---------> devel ---------------> testing -----------------> stable -----------------> LTS
|             ∧    ff-only merge             ff-only merge                rebase
| impl.       |
|             |
+-----> feature-branch
 large
 change
```

** "consistent" means, among other things, that all CI tests
(implemented via GitHub actions) pass successfully.

## Contributions

Bug reports and pull requests are welcome, if a feature is interesting
but not useful for me, I will keep it in a separate branch, I might
change my mind later :D . Issues and feature requests can be created
here: <https://github.com/jan-revay/initPC/issues>

## TODO

1. Merge and deprecate the InitNewPC repo InitPC repo on org GitHub and
   initAndroid repo.
1. Merge with LogidCfg repo
1. Test the Windows setup script on a VM
1. Create aliases for PowerShelly
1. Try merging the apt, flatpak, and snap install commands
1. Have a look at popOS packages and add the useful ones to other init
   scripts
1. Design a system for applying the configs on all my machines once they
   are updated here.
   * implement `refresh` alias (with CI idempotency tests)
   * add notification to .bashrc if the initPC or dotfiles are not up to
     date
1. Add more C++ tools from here:
   <https://github.com/cpp-best-practices/cppbestpractices/blob/master/02-Use_the_Tools_Available.md>
1. Add Bats automated tests
1. Try adding NixOS
1. Create CI tests on GitHub
1. Todos from the repo
1. Make the core Linux init script Debian-based (i.e. other distros just
   add stuff to the Debian base init script)
1. Consider replacing the Debian variants (Ubuntu, PopOS...) with a
   single Ansible script with conditionals.
1. Do some research on whether snap and flatpak packages work in WSL
   resp. which alternative package manager to use in WSL
1. Consider running the whole `./run_all.sh` script as sudo and removing
   `sudo` commands from the script.
1. Consider using <http://www.bashbooster.net/>,
   <https://github.com/bevry/dorothy>, <https://www.chezmoi.io/> or
   similar libraries (see: <https://www.chezmoi.io/comparison-table/>
   and <https://dotfiles.github.io/utilities/>).
1. Format to max 82 chars in a line.
1. Echo errors to stderr
1. Make the script compliant with the Google Bash style guide.
1. Consider running different files in different subshells i.e. not
   using the `source` command.
1. shared_gui_packages_install.sh
1. Automatic formatting of markdown files
1. Format markdown files (add linebreaks, beautify...)
1. Consolidate branches (unmerged feature branches).
1. Backup solution
1. Consider using
   <https://canonical-ubuntu-wsl.readthedocs-hosted.com/en/latest/tutorials/cloud-init/>
1. Why does the pre-commit hook (ShellCheck) fail locally but succeed in
   CI?
1. Add functional tests (see GitHub runners or ThePrimagen scripts as an
   example.)
1. Try to replicate my current MX3 master setup (high-res scrolling
   turned off) with just the logid driver, if possible.
1. Add Sway init and config files
1. Install VSC as .deb pkg & add config according to
   <https://code.visualstudio.com/docs/setup/linux>
1. Fix CI (stow logid.cfg)
1. Set up logid mouse
1. Automatic updates of Flatpaks and Snaps
1. Merge with my old initPC-like repos (private), compare gsettings
scripts with my old dconf dumps (backup_config repo)
1. Put packages equivalent to windows ones to Linux init script
1. Consider using ZFS or BTRFS for /home partition (or parts of the home dir)
     - https://gist.github.com/saurabhnanda/6720c13fe02c4ffd950c80f41091e199
     - https://www.quora.com/Which-format-is-faster-ZFS-or-Ext4
     - https://www.phoronix.com/review/ubuntu1910-ext4-zfs
     - https://medium.com/@rebrovadim/my-home-server-file-system-test-ext4-vs-zfs-spoiler-its-not-what-i-expected-e5e5802cbb66
     - https://www.pitsdatarecovery.net/blog/zfs-vs-ext4/
     - https://www.cbtnuggets.com/blog/technology/system-admin/linux-file-systems-ext4-vs-btrfs-vs-zfs
     - https://www.reddit.com/r/linux/comments/yrlljv/zfs_vs_btrfs_in_2022/
1. Remove jr-tutor commits (squash)

## Keyboard layout plans

- remap CapsLock to sth more useful
  * https://gist.github.com/nat-418/135a62fb9f37cc87cd70af1ab72e276a
  * https://superuser.com/questions/1678792/how-do-i-remap-cap-lock-to-make-other-keys-act-different
  * https://stackoverflow.com/questions/72450298/use-hyper-key-in-gnome-shortcuts (last post)
  * https://chatgpt.com/share/a4235ba1-74e9-4dc4-804a-44c03b610ce3
- a more ergonomic layout for programming (mainly for symbols)
- keyboard shortcuts
- https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
- https://www.x.org/releases/current/doc/xorg-docs/input/XKB-Config.html
- https://www.charvolant.org/doug/xkb/html/node5.html#SECTION00054000000000000000

## GTK configuration

- https://askubuntu.com/questions/72600/how-to-configure-gnome-3-through-a-configuration-file
- https://lazka.github.io/pgi-docs/Gtk-3.0/classes/Settings.html
- https://askubuntu.com/questions/1352344/add-bookmarks-to-nautilus-via-terminal'


## Bugs

### Bugs in CI

- CI was triggered when a .md file in Windows folder was changed (maybe because of the open pull request - investigate

## TOREAD

- <https://repology.org/>

## Aliases to add

1. Alias for home directory (one letter)
2. Alias for initPC repo (one letter)


## Similar repos

- <https://github.com/ThePrimeagen/dev> and
  <https://github.com/ThePrimeagen/.dotfiles>
- <https://gitlab.com/dwt1/dotfiles>
