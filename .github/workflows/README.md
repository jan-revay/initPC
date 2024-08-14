# README

## TODO P1

- separate system package manager packages and Flatpak/Snap/AppImage, move the Flatpak/Snap/AppImage related scripts
  to CommonInitScripts folder
- only run Flatpak/Snap/AppImage scripts in the Ubuntu GH runner (don't run that in the Docker containers - ifdef that)
- fix the CI tests
- fix Ubuntu GNOME install script
- add extension installs in Ubuntu GNOME

## TODO P3

- add build test for Android (Temrux)
- add run test for my .vimrc (maybe add it to the dotfiles repo instead)
- add run test for my bash dotfiles
- draw a dependency graph here
- in matrix executions - if one branch fails, the whole task should fail also (though the tests should be executed)
- clean the Actions logs (delete or hide outdated logs)
- Add CI for Mac init script
- Consider adding Ubuntu20.04 runner as well (backward compatibility)

## Flatpak/Snap/AppImage testing strategy

- As Flatpak/Snap/AppImage packages are system-independent there is probably no strong reason to test these on every Linux distribution
  separately. Moreover, as the Docker environment differs a bit from a regular full distribution, there would not be one-one parity in the
  bugs on the Docker container/specific Linux distribution.
- It makes much more sense to test Flatpak/Snap/AppImage on VM instead. For that, I can use the regular GitHub Ubuntu runners.
- The entire reason why these packaging formats even exist is to avoid differences and incompatibilities between distros, hence testing on
  Ubuntu GitHub runner should be sufficient. If not, I could add testing in a custom VM inside the Ubuntu GitHub runner, but I would need a strong
  reason for adding such complexity. Alternatively, I could use WSL2 for the tests as it is lightweight and should be able to run & install these
  package formats.

## Strategy for testing on different distros

- Currently, I use Docker containers to test setup scripts for distros other than Ubuntu.
- Alternatively, I could also use WSL2 if Docker is too restrictive.

## Triggers strategy (TODO)

- use matrix for versions of the same distro
- separate action for each distro with separate path filters
- the test itself will be a callable action that will be called from distro actions
- changes in WSL_Ubuntu will trigger checks of everything as everything depends on
  stuff in that directory (GitHub action for WSL_Ubuntu will call everything itself
  and everything will be made callable) - name the test "Test_Everything"
- pull_request event will also trigger Test_Everything
- TODO - but read Github Actions documentation first. Maybe there is an even more elegant way.

## Triggers

- for push: only stuff that was influenced by the change will be checked
- for pull request: everything will be run always (regardless of whether the files in question had changed or not) - the point of this is not to forget anything when changing filenames or adding new files

## Example GitHub actions from similar repos

### Dotfile managers

1. <https://github.com/bevry/dorothy/blob/master/.github/workflows/dorothy-workflow.yml>
2. Markdown management:
    <https://github.com/isocpp/CppCoreGuidelines/blob/master/.github/workflows/build.yml>
    <https://github.com/isocpp/CppCoreGuidelines/blob/master/scripts/Makefile>

### Other repos


## TODO CI checks to add

1. Check .md files with spellchecker
