# README

## TODO

- add build test for Android (Temrux)
- add run test for my .vimrc (maybe add it to the dotfiles repo instead)
- add run test for my bash dotfiles
- draw dependency graph here
- in matrix executions - if one branch fails, the whole task should fail also (though the tests should be executed)
- clean the Actions logs (delete or hide outdated logs)
- Add CI for Mac init script

## Problems

- snaps and flatpacks in Docker containers (consider making them work or avoiding them)

## Triggers strategy (TODO)

- use matrix for versions of the same distro
- separate action for each distro with separate paths filters
- the test itself will be a callable action that will be called from distro actions
- changes in WSL_Ubuntu will trigger checks of everything as everything depends on
  stuff in that directory (github action for WSL_Ubuntu will call everything itself
  and everything will be made callable) - name the test "Test_Everything"
- pull_request event will also trigger Test_Everything
- TODO - but read Github Actions documentation first. Maybe there is even more elegant way.

## Triggers

- for push only stuff that was influenced by the change will be checked
- for pull request everything will be run always (regardless whether files in question changed or not) - the point of this is not to forget anything when changing filenames or adding new files

## Example GitHub actions from similar repos

### Dotfile managers

1. <https://github.com/bevry/dorothy/blob/master/.github/workflows/dorothy-workflow.yml>
2. Markdown management:
    <https://github.com/isocpp/CppCoreGuidelines/blob/master/.github/workflows/build.yml>
    <https://github.com/isocpp/CppCoreGuidelines/blob/master/scripts/Makefile>

### Other repos


## TODO CI checks to add

1. Check .md files with spellchecker
