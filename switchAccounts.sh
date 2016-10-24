#!/bin/bash

COUNT=2
DELAY=200
CARD_NUMBER=6111009155198613
CARD_SECURITY=42826123
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
    xdotool key Control_L+l
    sd
}

rmURL() {
    xdotool key Shift_L+Delete
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

getTo() {
    URL="$1"
    move 391 182
    click
    selectURL
    fill "$URL"
    rmURL
    enter
    sd $PAGE_LOAD_DELAY
}

log_in() {
    email=$1
    getTo starbucks.com
    move 429 179
    click
    sd $PAGE_LOAD_DELAY
    move 186 485
    click
    fill "$email"
    tab
    fill LE_PASSWORd123
    enter
    sd $PAGE_LOAD_DELAY
}

log_out() {
    getTo starbucks.com
    move 391 182
    click
    move 377 352
    click
    sd $PAGE_LOAD_DELAY
}

addCard() {
    #move 191 350
    #click
    #sd $PAGE_LOAD_DELAY
    getTo starbucks.com/account/card
    move 99 467
    click
    sd $PAGE_LOAD_DELAY
    move 444 640
    click
    sd $PAGE_LOAD_DELAY
    tab
    tab
    fill $CARD_NUMBER
    tab
    fill $CARD_SECURITY
    tab
    tab
    tab
    enter
    #tab
    #fill "Michael"
    #tab
    #fill "Black"
    #tab
    #fill "3549 Iowa Avenue"
    #tab
    #fill "Apt C4"
    #tab
    #fill "Riverside"
    #tab
    #fill "California"
    #tab
    #fill "92521"
    #tab
    #fill "9093592050"
    #tab
    #tab
    #fill "April"
    #tab
    #fill "20"
    #tab
    #fill "Seattle"
    #enter
    sd $PAGE_LOAD_DELAY
    sd $PAGE_LOAD_DELAY
}

removeCard() {
    getTo starbucks.com/account/card
    move 101 775
    click
    sd $PAGE_LOAD_DELAY
    move 226 777
    click
    tab
    fill " "
    tab
    enter
    sd $PAGE_LOAD_DELAY
}

while [ 1 -lt 2 ]
do
    for address in `./permute TheStarbucksBlackCard@gmail.com $COUNT`
    do
        log_in "$address"
        addCard
        removeCard
        log_out
    done
done


