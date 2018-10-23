#!/usr/local/bin/bash

declare -A matrix
declare -r DEAD=""
declare -r LIVE="O"
declare -r SLEEPER=2
declare -r GAME=$1
declare -r NUM_ROWS=10
declare -r NUM_COLUMNS=20
declare COMPLETE=0
# declare -r RAND_VAL=0

let currtick=0

. random_matrix.bash
. functions.bash

while (( $# ))
do
    case "$1" in

        --random | -r)
            shift
            declare -r RAND_VAL=$1
            initMatrixRandom $RAND_VAL
            tick
            presentChoices
            exit 0
        ;;

        # --version | -v)
        #     version
        #     exit 0
        # ;;

# more code...

    esac
done
