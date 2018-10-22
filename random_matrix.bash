#!/usr/local/bin/bash

function initMatrixRandom() {
    for (( i=0;i<=num_rows;i++ ))
    do
        for (( j=0;j<num_columns;j++ ))
        do
            rand=$(($RANDOM%50))
            if [ "$rand" -gt "$1" ]
            then
                matrix[$i,$j]=$DEAD
            else
                matrix[$i,$j]=$LIVE
            fi
        done
    done
}
