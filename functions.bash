#!/usr/local/bin/bash

function clearMatrix() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            MATRIX[$i,$j]="$DEAD"
        done
    done
}



function print_matrix() {
    tput clear
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            tput cup $i $j
            echo "${MATRIX[$i,$j]}"
        done
    done
}



function getTopRow() {
    local topY=$(($1-1))
    local topLeftX=$(($2-1))
    local topMiddleX=$2
    local topRightX=$(($2+1))
    local result=0


    if [[ "$topY" -eq "-1" ]]; then
        topY=$((NUM_ROWS-1))
    fi

    if [[ "$topLeftX" -eq "-1" ]]; then
        topLeftX=$((NUM_COLUMNS-1))
    fi

    if [[ "$topRightX" -eq "$NUM_COLUMNS" ]]; then
        topRightX=0
    fi

    if [[ ${MATRIX[$topY,$topLeftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$topY,$topMiddleX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$topY,$topRightX]} = "$LIVE" ]]; then
        ((result++))
    fi

    echo $result
}



function getMiddleRow() {
    local y=$1
    local leftX=$(($2-1))
    local rightX=$(($2+1))
    local result=0

    if [[ "$leftX" -eq "-1" ]]; then
        leftX=$((NUM_COLUMNS-1))
    fi

    if [[ "$rightX" -eq "$NUM_COLUMNS" ]]; then
        rightX=0
    fi

    if [[ ${MATRIX[$y,$leftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$y,$rightX]} = "$LIVE" ]]; then
        ((result++))
    fi

    echo $result
}



function getBottomRow() {
    local bottomY=$(($1+1))
    local bottomLeftX=$(($2-1))
    local bottomMiddleX=$2
    local bottomRightX=$(($2+1))
    local result=0


    if [[ "$bottomY" -eq "$NUM_ROWS" ]]; then
        bottomY=0
    fi

    if [[ "$bottomLeftX" -eq "-1" ]]; then
        bottomLeftX=$((NUM_COLUMNS-1))
    fi

    if [[ "$bottomRightX" -eq "$NUM_COLUMNS" ]]; then
        bottomRightX=0
    fi

    if [[ ${MATRIX[$bottomY,$bottomLeftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$bottomY,$bottomMiddleX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${MATRIX[$bottomY,$bottomRightX]} = "$LIVE" ]]; then
        ((result++))
    fi

    echo $result
}



function checkNeigbours() {
    local y=$1
    local x=$2
    local top=0
    local bottom=0
    local middle=0

    top=$(getTopRow "$y" "$x")
    middle=$(getMiddleRow "$y" "$x")
    bottom=$(getBottomRow "$y" "$x")

    echo $((top+middle+bottom))

}



function checkMatrix() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            amount=$(checkNeigbours $i $j)
            if [[ "$amount" -eq 3 ]]; then
                tempMatrix[$i,$j]=$LIVE
            elif [[ "$amount" -lt 2 ]] || [[ "$amount" -gt 3 ]]; then
                tempMatrix[$i,$j]=$DEAD
            else
                tempMatrix[$i,$j]=${MATRIX[$i,$j]}
            fi
        done
    done

    for key in "${!tempMatrix[@]}"; do
        MATRIX[$key]=${tempMatrix[$key]}
    done
}



function presentChoices() {
    read -r -p "q=quit, t=tick, r=restart, s=start. Choice: " choice
    if [ "$choice" = "q" ]; then
        echo "Bye!"
        exit 0
    elif [ "$choice" = "r" ]; then
        $SELECTED_PATTERN
        ((CURRTICK = 0))
        print_matrix
    elif [ "$choice" = "t" ]; then
        tick
    elif [ "$choice" = "s" ]; then
        while [ "$COMPLETE" = "false" ]; do
            tick
            sleep "$SLEEPER"
        done
    fi
    presentChoices
}



function tick() {
    checkMatrix
    print_matrix
    ((CURRTICK++))

    echo "--------------------------------------------"
    echo "Current tick: $CURRTICK"
    echo "--------------------------------------------"
}
