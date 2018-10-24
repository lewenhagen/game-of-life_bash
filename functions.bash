#!/usr/local/bin/bash

function initMatrix() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
            matrix[$i,$j]="$LIVE"
        done
    done

    matrix["0,0"]="$LIVE"
    matrix[4,5]="$LIVE"
    matrix[6,5]="$LIVE"
    matrix[3,2]="$LIVE"
    matrix[3,3]="$LIVE"
    matrix[1,5]="$LIVE"

}

function clearMatrix() {
    for (( i=0;i<NUM_ROWS;i++ )); do
        for (( j=0;j<NUM_COLUMNS;j++ )); do
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
            echo "${matrix[$i,$j]}"
        done
    done
    # echo "\n"
}


function getTopRow() {
    local topY=$(($1-1))
    local topLeftX=$(($2-1))
    local topMiddleX=$2
    local topRightX=$(($2+1))
    local result=0


    if [[ "$topY" -eq "-1" ]]; then
        topY=$(($NUM_ROWS-1))
    fi

    if [[ "$topLeftX" -eq "-1" ]]; then
        topX=$(($NUM_COLUMNS-1))
    fi

    if [[ "$topRightX" -eq "$NUM_COLUMNS" ]]; then
        topX=0
    fi

    if [[ ${matrix[$topY,$topLeftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${matrix[$topY,$topMiddleX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${matrix[$topY,$topRightX]} = "$LIVE" ]]; then
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
        leftX=$(($NUM_COLUMNS-1))
    fi

    if [[ "$rightX" -eq "$NUM_COLUMNS" ]]; then
        rightX=0
    fi

    if [[ ${matrix[$y,$leftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${matrix[$y,$rightX]} = "$LIVE" ]]; then
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
        bottomLeftX=$(($NUM_COLUMNS-1))
    fi

    if [[ "$bottomRightX" -eq "$NUM_COLUMNS" ]]; then
        bottomRightX=0
    fi

    if [[ ${matrix[$bottomY,$bottomLeftX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${matrix[$bottomY,$bottomMiddleX]} = "$LIVE" ]]; then
        ((result++))
    fi

    if [[ ${matrix[$bottomY,$bottomRightX]} = "$LIVE" ]]; then
        ((result++))
    fi


    echo $result
}

function checkNeigbours() {
    # AMOUNT=0
    local y=$1
    local x=$2
    local top=0
    local bottom=0
    local middle=0



    top=$(getTopRow $y $x)
    middle=$(getMiddleRow $y $x)
    bottom=$(getBottomRow $y $x)

    echo $(($top+$middle+$bottom))

}


function checkMatrix() {
    declare -A tempMatrix

    for (( i=0;i<NUM_ROWS;i++ ))
    do
        for (( j=0;j<NUM_COLUMNS;j++ ))
        do
            amount=$(checkNeigbours $i $j)

            if [[ "$amount" -eq 3 ]]
            then
                tempMatrix[$i,$j]=$LIVE
                # matrix[$i,$j]=$LIVE
            elif [[ "$amount" -lt 2 ]] || [[ "$amount" -gt 3 ]]
            then
                tempMatrix[$i,$j]=$DEAD
            else
                tempMatrix[$i,$j]=${matrix[$i,$j]}
            fi

        done
    done
    clearMatrix
    for key in "${!tempMatrix[@]}"; do
    matrix[$key]=${tempMatrix[$key]}
done
}

function presentChoices() {
    read -p "q=quit, t=tick, r=restart, n=new, s=start. Choice: " choice
    if [ "$choice" = "q" ]
    then
        echo "Bye!"
        exit 0
    elif [ "$choice" = "r" ]
    then
        initMatrixRandom $RAND_VAL
        ((currtick = 0))
        tick
    elif [ "$choice" = "n" ]
    then
        initMatrix
        ((currtick = 0))
        tick
    elif [ "$choice" = "t" ]
    then
        tick
    elif [ "$choice" = "s" ]
    then
        while [ "$COMPLETE" = "false" ]
        do
            tick
            sleep $SLEEPER
        done
    fi
    presentChoices
}

function tick() {
    checkMatrix
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
