#!/bin/bash

clear

BOLD=$(tput bold)
RESET=$(tput sgr0)
cols=$(tput cols)

cprint() {
    row=$1
    text="$2"
    len=${#text}
    col=$(( (cols - len) / 2 ))
    tput cup $row $col
    printf "%b%s%b" "$BOLD" "$text" "$RESET"
}


border="+----------------------------------------------------------------+"

cprint 2 "$border"
cprint 3 "MINI PROJECT ON"
cprint 4 "$border"

cprint 6 "* EMPLOYEE PAYROLL MANAGEMENT SYSTEM *"

cprint 9  "Developed By"

indent=$(( (cols / 2) - 10 ))

tput cup 11 $indent; printf "%b1. Siftainraza%b" "$BOLD" "$RESET"
tput cup 12 $indent; printf "%b2. Sindhu%b"       "$BOLD" "$RESET"
tput cup 13 $indent; printf "%b3. Varsha%b"       "$BOLD" "$RESET"
tput cup 14 $indent; printf "%b4. Tanisha%b"      "$BOLD" "$RESET"

cprint 17 "Guided By : Dr. N. Guruprasad"

cprint 20 "Press ENTER key to go to MAIN MENU...!"

tput cup 22 0
read
sh Main_Menu.sh

