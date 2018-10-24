#!/usr/local/bin/bash

# declare -A matrix
# declare -i NUM_ROWS=10
# declare -i NUM_COLUMNS=20

function random() {
    for (( i=0;i<NUM_ROWS;i++ ))
    do
        for (( j=0;j<NUM_COLUMNS;j++ ))
        do
            rand=$((RANDOM%50))
            if (( "$rand" >= "$DENSITY" ))
            then
                matrix[$i,$j]=$DEAD
            else
                matrix[$i,$j]=$LIVE
            fi
        done
    done
}


function matrix1() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            matrix[$i,$j]="$DEAD"
        done
    done

    matrix[0,0]="$LIVE"
    matrix[0,1]="$LIVE"
    matrix[0,2]="$LIVE"
    matrix[0,3]="$LIVE"
    matrix[0,4]="$LIVE"

}

function beacon() {
    NUM_ROWS=6
    NUM_COLUMNS=6
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            matrix[$i,$j]="$DEAD"
        done
    done
    matrix[1,1]="$LIVE"
    matrix[1,2]="$LIVE"
    matrix[2,1]="$LIVE"
    matrix[3,4]="$LIVE"
    matrix[4,3]="$LIVE"
    matrix[4,4]="$LIVE"
}

function glider() {
    NUM_ROWS=20
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            matrix[$i,$j]="$DEAD"
        done
    done
    matrix[9,11]="$LIVE"
    matrix[10,9]="$LIVE"
    matrix[10,11]="$LIVE"
    matrix[11,10]="$LIVE"
    matrix[11,11]="$LIVE"
}

function beehive() {
    NUM_ROWS=10
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            matrix[$i,$j]="$DEAD"
        done
    done

    matrix[1,2]="$LIVE"
    matrix[1,3]="$LIVE"
    matrix[2,1]="$LIVE"
    matrix[2,4]="$LIVE"
    matrix[3,2]="$LIVE"
    matrix[3,3]="$LIVE"
}

function ship() {
    NUM_ROWS=10
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            matrix[$i,$j]="$DEAD"
        done
    done

    matrix[2,9]="$LIVE"
    matrix[3,9]="$LIVE"
    matrix[2,10]="$LIVE"
    matrix[4,10]="$LIVE"
    matrix[3,11]="$LIVE"
    matrix[4,11]="$LIVE"
}

function pentomino() {
    NUM_ROWS=20
    NUM_COLUMNS=20
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            matrix[$i,$j]="$DEAD"
        done
    done

    matrix[8,12]="$LIVE"
    matrix[8,13]="$LIVE"
    matrix[9,11]="$LIVE"
    matrix[9,12]="$LIVE"
    matrix[10,12]="$LIVE"
}
