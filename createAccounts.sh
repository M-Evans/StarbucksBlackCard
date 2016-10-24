#!/bin/bash

if [ $# -ne 1 ]
then
    echo "ERROR: missing email address count" >&2
    exit 1
fi

NUM=0
COUNT=$1
DELAY=0
DRY_RUN=true
#PAGE_LOAD_DELAY=10000
PAGE_LOAD_DELAY=2000

sd() {
    if [ $# -eq 0 ]
    then
        sleep `bc <<<"scale=3; $DELAY/1000"`
    else
        sleep `bc <<<"scale=3; $1/1000"`
    fi
}

selectURL() {
    xdotool key control+l
    sd
}

backspace() {
    xdotool key BackSpace
    sd
}

click() {
    xdotool click 1
    sd
}

fill() {
    str="$@"
    for i in $(eval echo "{0..${#str}}")
    do
        char="${str:$i:1}"
        if [ "$char" == ' ' ]
        then
            xdotool key space
        elif [ "$char" == ':' ]
        then
            #xdotool key 'shift+semicolon'
            xdotool key colon
        elif [ "$char" == '.' ]
        then
            xdotool key period
        elif [ "$char" == '/' ]
        then
            xdotool key slash
        elif [ "$char" == '_' ]
        then
            xdotool key underscore
        elif [ "$char" == '@' ]
        then
            xdotool key at
        else
            xdotool key "$char"
        fi
    done
    sd
}

enter() {
    xdotool key Return
    sd
}

up() {
    xdotool key Up
    sd
}

down() {
    xdotool key Down
    sd
}

left() {
    xdotool key Left
    sd
}

right() {
    xdotool key Right
    sd
}

tab() {
    xdotool key Tab
    sd
}

move() {
    xdotool mousemove "$1" "$2"
    sd
}

mover() {
    xdotool mousemove_relative -- "$1" "$2"
    sd
}

create() {
    move 262 478
    click
    selectURL
    backspace
    fill http://starbucks.com/account/create
    enter
    sd $PAGE_LOAD_DELAY
    move 262 478
    click
    fill Michael
    tab
    fill Black
    tab
    fill "$1"
    tab
    fill LE_PASSWORd123
    tab
    tab
    tab
    fill " "
    tab
    if [ "$DRY_RUN" != "true" ]
    then
        enter
    else
        echo "Potential fraud count: $NUM"
    fi
    (( NUM++ ))
    sd $PAGE_LOAD_DELAY
}

for address in `./permute TheStarbucksBlackCard@gmail.com $COUNT`
do
    create "$address"
done

echo "Michael Black is potentially wanted for \$$(bc <<<"10000 * ($NUM-1)") in fradulent damages"
