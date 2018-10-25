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
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done

    MATRIX[8,12]="$LIVE"
    MATRIX[8,13]="$LIVE"
    MATRIX[9,11]="$LIVE"
    MATRIX[9,12]="$LIVE"
    # shellcheck disable=SC2034
    MATRIX[10,12]="$LIVE"
}
