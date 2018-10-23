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

function autoPlay() {
    print_matrix
}

function presentChoices() {
    read -p "q=quit, t=tick, r=restart, s=start. Choice: " choice
    if [ "$choice" = "q" ]
    then
        echo "Bye!"
        exit 0
    elif [ "$choice" = "r" ]
    then
        initMatrixRandom $RAND_VAL
        ((currtick = 0))
        tick
    elif [ "$choice" = "t" ]
    then
        tick
    elif [ "$choice" = "s" ]
    then
        while true
        do
            tick
            sleep 2
        done
    fi
    presentChoices
}

function tick() {
    # checkMatrix
    print_matrix
    ((currtick++))
    echo "--------------------------------------------"
    echo "Current tick: $currtick"
    echo "--------------------------------------------"
    # presentChoices
    # if [ "$choice" = "q" ]
    # then
    #     echo "Bye!"
    #     exit 0
    # elif [ "$choice" = "r" ]
    # then
    #     initMatrixRandom $RAND_VAL
    #     ((currtick = 0))
    #     tick
    # elif [ "$choice" = "t" ]
    # then
    #     tick
    # elif [ "$choice" = "s" ]
    # then
    #     while true
    #     do
    #         echo "afgfgfdg"
    #         tick
    #         sleep 2
    #     done
    # fi
}
