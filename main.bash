#!/usr/local/bin/bash

declare -A matrix
declare -r DEAD=""
declare -r LIVE="O"
declare -r SLEEPER=2
declare -r GAME=$1
declare -r NUM_ROWS=10
declare -r NUM_COLUMNS=20
declare -r RAND_VAL=$2

let currtick=1


. random_matrix.bash
. functions.bash

if [ "$1" = "random" ]
then
    initMatrixRandom $RAND_VAL
else
    initMatrix
fi
tick
