#!/bin/bash -x

if [[ "${__INITPC_PRELUDE_SOURCED__}" != "true" ]]; then
    __INITPC_PRELUDE_SOURCED__='true'

    # TODO toread:
    # https://linuxopsys.com/topics/customizing-bash-prompt-in-linux-changing-colors
    # https://gist.github.com/vratiu/9780109
    # https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
    # https://opensource.com/article/19/9/linux-terminal-colors
    # https://linuxopsys.com/topics/customizing-bash-prompt-in-linux-changing-colors
    # https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
    # https://unix.stackexchange.com/questions/148/colorizing-your-terminal-and-shell-environment
    # https://dev.to/ifenna__/adding-colors-to-bash-scripts-48g4

    set -e # exit on error
    set -x # debug logging
    # TODO try removing -x option from scripts that include this

    # shellcheck disable=SC2034
    readonly RED='\033[0;31m'
    # shellcheck disable=SC2034
    readonly IYELLOW='\033[0;93m' # high intensity yellow
    # shellcheck disable=SC2034
    readonly GREEN='\033[0;32m'
    # shellcheck disable=SC2034
    readonly NC='\033[0m' # No Color

    # makes the echo prompt yellow to improve readability
    export PS4="\[${IYELLOW}\]+ \[${NC}\]"

    # TODO renumber the exit codes according to the docs bellow
    # SEE: https://manpages.ubuntu.com/manpages/lunar/man3/sysexits.h.3head.html
    # SEE: https://tldp.org/LDP/abs/html/exitcodes.html
    # shellcheck disable=SC2034
    readonly EXIT_SUCCESS=0
    # shellcheck disable=SC2034
    readonly EXIT_FILE_IO_ERROR=50
    # TODO - consider even better error code number (guaranteed to be unique)
    # apt-get install returns 100 if a package was not found... 100 is not a good error code. >IMPORTANT<
    # shellcheck disable=SC2034
    readonly EXIT_INCORRECT_PLATFORM=99
    # shellcheck disable=SC2034
    readonly EXIT_INVALID_ARGUMENT=10
    # TODO - finish
    #

    # @param $1 - distro ID
    function distro_is
    {
        # TODO test the test... and make sure it is correct/valid/general enough
        # TODO see:
        # https://www.freedesktop.org/software/systemd/man/os-release.html
        # https://0pointer.de/blog/projects/os-release.html
        # https://manpages.ubuntu.com/manpages/focal/man5/os-release.5.html
        # https://docs.oracle.com/cd/E88353_01/html/E37852/os-release-5.html
        # https://github.com/chef/os_release
        # https://man.archlinux.org/man/os-release.5.en
        # https://manpages.debian.org/testing/systemd/os-release.5.en.html
        # https://www.commandlinux.com/man-page/man5/os-release.5.html
        # https://unix.stackexchange.com/questions/351557/on-what-linux-distributions-can-i-rely-on-the-presence-of-etc-os-release

        if [[ ! -f /etc/os-release ]]; then
            echo "/etc/os-release file not found."
            echo "Aborting."
            exit ${EXIT_INCORRECT_PLATFORM}
        fi

        local ID
        # shellcheck disable=SC1091
        ID=$(source /etc/os-release && echo "${ID}")
        echo "Distro ID=${ID}"

        if [[ "${ID}" != "$1" ]]; then
            echo "Error: The distro ID is ${ID} but it should be $1! Aborting."
            exit ${EXIT_INCORRECT_PLATFORM}
        fi
    }

    # TODO make distro_version_le
    # @param $1 - minimal distro major version
    function distro_version_ge
    {
        if [[ ! -f /etc/os-release ]]; then
            echo "/etc/os-release file not found."
            echo "Aborting."
            exit ${EXIT_INCORRECT_PLATFORM}
        fi

        local VERSION_ID
        # shellcheck disable=SC1091
        VERSION_ID="$(source /etc/os-release && echo "${VERSION_ID}")"
        echo "Version ID=${VERSION_ID}"

        if [[ ${VERSION_ID} == "" ]]; then
            echo "Warning: The version ID is empty."
            return
        fi

        local MAJOR_VERSION
        MAJOR_VERSION="$(echo "${VERSION_ID}" | grep -o "^[0-9]\+")"

        if [[ "${MAJOR_VERSION}" -lt "$1" ]]; then
            echo "Error: Major version is ${MAJOR_VERSION} but it should be at least $1! Aborting."
            exit ${EXIT_INCORRECT_PLATFORM}
        fi
    }

    function gnome_present
    {
        local GNOME_PRESENT="no"

        if gnome-extensions --version; then
            GNOME_PRESENT="yes"
            echo "gnome-extensions executable found."
            echo "Assuming that GNOME is present"
        fi

        if [[ ${GNOME_PRESENT} != "$1" ]]; then
            echo "GNOME_PRESENT != $1. Aborting."
            exit ${EXIT_INCORRECT_PLATFORM}
        fi
    }

    print0()
    {
        [ "$#" -eq 0 ] || printf '%s\0' "$@"
    }
fi
