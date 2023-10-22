# UbuntuCLI
Scripts in this directory serve as a base to all other Linux init scripts (they are called from Debian, Ubuntu, PopOS, Kubuntu... installers).

## TODO

- Split package lists to multiple categories by usefulness and add CLI parameter to choose how large list of packages to install i. e. `./run_init.sh minimal`, `./run_init.sh balanced`, `./run_init.sh experimental`... 
- split each list to a separate file?
- separate package lists and installation scripts?
- use the package groups (in all branches) rather than the `minimal` branch
- minimal branch can therefore be renamed to LTS or sth. like that.
- start using tags on stable branch
