#!/usr/local/bin/bash

function initMatrixRandom() {
    for (( i=0;i<NUM_ROWS;i++ ))
    do
        for (( j=0;j<NUM_COLUMNS;j++ ))
        do
            rand=$(($RANDOM%50))
            if (( "$rand" >= "$1" ))
            then
                matrix[$i,$j]=$DEAD
            else
                matrix[$i,$j]=$LIVE
            fi
        done
    done
}
