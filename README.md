# initPC - MINIMAL BRANCH (WIP)

A collection of (C++, Python & Rust development-oriented) config scripts & dotfiles to quickly init new machines for my personal use.

## How to use

1. `git clone https://github.com/jan-revay/initPC.git`
2. `cd initPC/<Platform>/` for example `cd initPC/WSL_Ubuntu_22.04/`
3. `./run_all.sh`

## Branches

1. **minimal** - debloated, stable, tested, production-ready, and not expected to change in the _yearly horizon_. Only necessary stuff. Possibly useful for detecting whether bugs in the stable branch are caused by the init script or to be used as a substitute for the stable branch while the stable branch has a critical bug.
2. **stable** - stable, tested, production-ready, and not expected to change much in the _monthly horizon_.
3. **testing** - shouldn't be broken or inconsistent most of the time, useful changes from devel that are queued to be accepted to stable (or rejected).
4. **devel** - development and experiments, might be inconsistent or broken regularly. Useful, consistent, and fully functional changes from the branch devel might be merged into the branch testing.

Minimal, stable, and testing branches are expected to be _always in a consistent state_ so that they can always be used to init a machine e.g. VM or a bootable partition. The devel branch is expected to be broken from time to time (e.g. when working on larger changes "per partes") and it might not always be possible to init a machine using it.

### Workflow

```text
               functional &             tested &
  impl.         consistent               useful            necessary
O------> devel --------------> testing ----------> stable -----------> minimal
```

## TODO


