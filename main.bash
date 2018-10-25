#!/usr/local/bin/bash
SCRIPT=$( basename "$0" )
VERSION="1.0.0"

declare -A MATRIX
declare -A tempMatrix
declare -r DEAD=""
declare -r LIVE="x"
declare -r SLEEPER=1
# declare -r GAME=$1
declare -i NUM_ROWS=20
declare -i NUM_COLUMNS=40
declare COMPLETE=false
declare -i CURRTICK=0
declare -A patterns
declare SELECTED_PATTERN
declare DENSITY=10

patterns=(
    [random]=1
    [matrix1]=1
    [beacon]=1
    [glider]=1
    [beehive]=1
    [ship]=1
    [pentomino]=1
    )

#
# Load external files
#
. load.bash
. functions.bash

#
# Message to display for usage and help.
#
function usage
{
    local txt=(
        "--------------------------------------------------------------------------------------------"
        "$SCRIPT is a bash implementation of Conway's Game Of Life."
        "Usage: $SCRIPT [options] <command> [arguments]"
        "--------------------------------------------------------------------------------------------"
        "Command:"
        "  load [pattern]           Loads a pre-defined pattern."
        "  load [random] <int>      Loads a random pattern with <int> density (1-30). Default is 10"
        "  patterns                 Displays available patterns."
        ""
        "Options:"
        "  --help, -h          Print help."
        "  --version, -v       Print version."
        "--------------------------------------------------------------------------------------------"
        "There are ${#patterns[@]} available patterns:"
        "${!patterns[@]}"
        "--------------------------------------------------------------------------------------------"
    )

    printf "%s\n" "${txt[@]}"
}

#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
        "For an overview of the command, execute:"
        "$SCRIPT --help"
    )

    [[ $message ]] && printf "%" "$message\n"

    printf "%s\n" "${txt[@]}"
}

#
# Message to display for version.
#
function version
{
    local txt=(
        "$SCRIPT version $VERSION"
    )
    printf "%s\n" "${txt[@]}"
}


while (( $# ))
do
    case "$1" in

        load)
            shift
            if [ -z "${1+x}" ] || ! [ "${patterns[$1]+isset}" ]; then
                badUsage
                exit 1
            fi
            SELECTED_PATTERN=$1
            if ! [[ -z "$2" ]]; then
                DENSITY=$2
            fi
            $1
            print_matrix
            presentChoices
            exit 0
        ;;

        patterns)
            echo "There are ${#patterns[@]} available patterns:"
            echo "${!patterns[@]}"
            exit 0
        ;;

        --help | -h)
            usage
            exit 0
        ;;

        --version | -v)
            version
            exit 0
        ;;

        *)
            badUsage "$@"
            exit 1
        ;;
    esac
done
