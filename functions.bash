#!/usr/local/bin/bash

function initMatrix() {
    for (( i=0;i<=NUM_ROWS;i++ ))
    do
        for (( j=0;j<NUM_COLUMNS;j++ ))
        do
            matrix[$i,$j]="$DEAD"
        done
    done
}

function print_matrix() {
    tput clear
    for (( i=0;i<NUM_ROWS;i++ ))
    do
        for (( j=0;j<NUM_COLUMNS;j++ ))
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
    read -p "q=quit, t=tick, r=restart. Choice: " choice
    if [ "$choice" = "q" ]
    then
        echo "Bye!"
        exit 0
    elif [ "$choice" = "r" ]
    then
        initMatrixRandom $RAND_VAL
        ((currtick = 1))
        tick
    elif [ "$choice" = "t" ]
    then
        ((currtick++))
        tick
    fi
}
