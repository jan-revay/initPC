# README

## TODO

- add build test for Android (Temrux)
- add run test for my .vimrc (maybe add it to the dotfiles repo instead)
- draw dependency graph here
- in matrix executions - if one branch fails, the whole task should fail also (though the tests should be executed)

## Triggers

- for push only stuff that was influenced by the change will be checked
- for pull request everything will be run always (regardless whether files in question changed or not) - the point of this is not to forget anything when changing filenames or adding new files

## Example GitHub actions from similar repos

### Dotfile managers

1. <https://github.com/bevry/dorothy/blob/master/.github/workflows/dorothy-workflow.yml>
2. 

### Other repos
