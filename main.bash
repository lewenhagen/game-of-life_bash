#!/usr/local/bin/bash

declare -A matrix
declare -a tempMatrix
declare -r DEAD=""
declare -r LIVE="x"
declare -r SLEEPER=1
declare -r GAME=$1
declare -i NUM_ROWS=10
declare -i NUM_COLUMNS=20
declare COMPLETE=false


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

        --start | -s)
            shift
            NUM_ROWS=$1
            NUM_COLUMNS=$1
            initMatrixRandom 10
            tick
            presentChoices
            exit 0
        ;;

        --init)
            shift
            initMatrix
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
