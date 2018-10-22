#!/usr/local/bin/bash

declare -A matrix
declare -r DEAD=""
declare -r LIVE="O"
declare -r SLEEPER=2
let currtick=1

num_rows=10
num_columns=20

. random_matrix.bash

# Initialize matrix with all dead cells
function initMatrix() {
    for (( i=0;i<=num_rows;i++ ))
    do
        for (( j=0;j<num_columns;j++ ))
        do
            matrix[$i,$j]="$DEAD"
        done
    done
}

function print_matrix() {
    tput clear
    for (( i=0;i<num_rows;i++ ))
    do
        for (( j=0;j<num_columns;j++ ))
        do
            tput cup $i $j
            printf "${matrix[$i,$j]}"
        done
    done
    printf "\n"
}

function tick() {
    # checkMatrix
    print_matrix
    echo "Current tick: $currtick"
    read -p "q=quit, t=tick. Choice: " choice
    if [ "$choice" = "q" ]
    then
        echo "Bye!"
        exit 0
    elif [ "$choice" = "t" ]
    then
        ((currtick++))
        tick
    fi
}

initMatrixRandom 6
tick
# matrix[2,1]=$LIVE
