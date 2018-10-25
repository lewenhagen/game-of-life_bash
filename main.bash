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
# Functions to load patterns
#

function random() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            rand=$((RANDOM%50))
            if (( "$rand" >= "$DENSITY" )); then
                MATRIX[$i,$j]=$DEAD
            else
                MATRIX[$i,$j]=$LIVE
            fi
        done
    done
}


function matrix1() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done

    MATRIX[0,0]="$LIVE"
    MATRIX[0,1]="$LIVE"
    MATRIX[0,2]="$LIVE"
    MATRIX[0,3]="$LIVE"
    MATRIX[0,4]="$LIVE"

}

function beacon() {
    NUM_ROWS=6
    NUM_COLUMNS=6
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done
    MATRIX[1,1]="$LIVE"
    MATRIX[1,2]="$LIVE"
    MATRIX[2,1]="$LIVE"
    MATRIX[3,4]="$LIVE"
    MATRIX[4,3]="$LIVE"
    MATRIX[4,4]="$LIVE"
}

function glider() {
    NUM_ROWS=20
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done
    MATRIX[9,11]="$LIVE"
    MATRIX[10,9]="$LIVE"
    MATRIX[10,11]="$LIVE"
    MATRIX[11,10]="$LIVE"
    MATRIX[11,11]="$LIVE"
}

function beehive() {
    NUM_ROWS=10
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done

    MATRIX[1,2]="$LIVE"
    MATRIX[1,3]="$LIVE"
    MATRIX[2,1]="$LIVE"
    MATRIX[2,4]="$LIVE"
    MATRIX[3,2]="$LIVE"
    MATRIX[3,3]="$LIVE"
}

function ship() {
    NUM_ROWS=10
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done

    MATRIX[2,9]="$LIVE"
    MATRIX[3,9]="$LIVE"
    MATRIX[2,10]="$LIVE"
    MATRIX[4,10]="$LIVE"
    MATRIX[3,11]="$LIVE"
    MATRIX[4,11]="$LIVE"
}

function pentomino() {
    NUM_ROWS=20
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS; j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done

    MATRIX[8,12]="$LIVE"
    MATRIX[8,13]="$LIVE"
    MATRIX[9,11]="$LIVE"
    MATRIX[9,12]="$LIVE"
    MATRIX[10,12]="$LIVE"
}


#
# General functions
#

function clearMatrix() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done
}



function print_matrix() {
    tput clear
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            tput cup $i $j
            echo "${MATRIX[$i,$j]}"
        done
    done
}



function getTopRow() {
    local topY=$(($1-1))
    local topLeftX=$(($2-1))
    local topMiddleX=$2
    local topRightX=$(($2+1))
    local result=0


    if [[ "$topY" -eq "-1" ]]; then
        topY=$((NUM_ROWS-1))
    fi

    if [[ "$topLeftX" -eq "-1" ]]; then
        topLeftX=$((NUM_COLUMNS-1))
    fi

    if [[ "$topRightX" -eq "$NUM_COLUMNS" ]]; then
        topRightX=0
    fi

    if [[ ${MATRIX[$topY,$topLeftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$topY,$topMiddleX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$topY,$topRightX]} = "$LIVE" ]]; then
        ((result++))
    fi

    echo $result
}



function getMiddleRow() {
    local y=$1
    local leftX=$(($2-1))
    local rightX=$(($2+1))
    local result=0

    if [[ "$leftX" -eq "-1" ]]; then
        leftX=$((NUM_COLUMNS-1))
    fi

    if [[ "$rightX" -eq "$NUM_COLUMNS" ]]; then
        rightX=0
    fi

    if [[ ${MATRIX[$y,$leftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$y,$rightX]} = "$LIVE" ]]; then
        ((result++))
    fi

    echo $result
}



function getBottomRow() {
    local bottomY=$(($1+1))
    local bottomLeftX=$(($2-1))
    local bottomMiddleX=$2
    local bottomRightX=$(($2+1))
    local result=0


    if [[ "$bottomY" -eq "$NUM_ROWS" ]]; then
        bottomY=0
    fi

    if [[ "$bottomLeftX" -eq "-1" ]]; then
        bottomLeftX=$((NUM_COLUMNS-1))
    fi

    if [[ "$bottomRightX" -eq "$NUM_COLUMNS" ]]; then
        bottomRightX=0
    fi

    if [[ ${MATRIX[$bottomY,$bottomLeftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$bottomY,$bottomMiddleX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$bottomY,$bottomRightX]} = "$LIVE" ]]; then
        ((result++))
    fi

    echo $result
}



function checkNeigbours() {
    local y=$1
    local x=$2
    local top=0
    local bottom=0
    local middle=0

    top=$(getTopRow "$y" "$x")
    middle=$(getMiddleRow "$y" "$x")
    bottom=$(getBottomRow "$y" "$x")

    echo $((top+middle+bottom))

}



function checkMatrix() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            amount=$(checkNeigbours $i $j)
            if [[ "$amount" -eq 3 ]]; then
                tempMatrix[$i,$j]=$LIVE
            elif [[ "$amount" -lt 2 ]] || [[ "$amount" -gt 3 ]]; then
                tempMatrix[$i,$j]=$DEAD
            else
                tempMatrix[$i,$j]=${MATRIX[$i,$j]}
            fi
        done
    done

    for key in "${!tempMatrix[@]}"; do
        MATRIX[$key]=${tempMatrix[$key]}
    done
}



function presentChoices() {
    read -r -p "q=quit, t=tick, r=restart, s=start. Choice: " choice
    if [ "$choice" = "q" ]; then
        echo "Bye!"
        exit 0
    elif [ "$choice" = "r" ]; then
        $SELECTED_PATTERN
        ((CURRTICK = 0))
        print_matrix
    elif [ "$choice" = "t" ]; then
        tick
    elif [ "$choice" = "s" ]; then
        while [ "$COMPLETE" = "false" ]; do
            tick
            sleep "$SLEEPER"
        done
    fi
    presentChoices
}



function tick() {
    checkMatrix
    print_matrix
    ((CURRTICK++))

    echo "--------------------------------------------"
    echo "Current tick: $CURRTICK"
    echo "--------------------------------------------"
}



#
# Load external files
#
# . load.bash
# . functions.bash

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
