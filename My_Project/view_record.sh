#!/bin/bash

clear

BOLD=$(tput bold)
RESET=$(tput sgr0)

view_choice='Y'

while [ "$view_choice" = "y" -o "$view_choice" = "Y" ]
do
    if [ ! -f EMP_DBF ]
    then
        clear
        tput cup 5 30
        echo "${BOLD}NO FILE EXISTS.${RESET}"

        tput cup 7 30
        echo -n "${BOLD}Press ENTER key to continue.....${RESET}"
        read key
        sh emp_file_mgmt.sh
    else
        clear

        # Title
        tput cup 2 40
        echo "${BOLD}MENU FOR VIEWING RECORD${RESET}"

        # Input prompt
        tput cup 5 20
        echo -n "${BOLD}Enter Employee Code to view: ${RESET}"
        read emp_code

        record=$(grep "^$emp_code:" EMP_DBF)

        if [ -n "$record" ]
        then
            code=$(echo "$record" | cut -d: -f1)
            name=$(echo "$record" | cut -d: -f2)
            desg=$(echo "$record" | cut -d: -f3)
            dept=$(echo "$record" | cut -d: -f4)
            sal=$(echo "$record" | cut -d: -f5)

            tput cup 7 20
            echo "${BOLD}Employee details are:${RESET}"

            tput cup 9 20
            echo "${BOLD}Code        :${RESET} $code"

            tput cup 10 20
            echo "${BOLD}Name        :${RESET} $name"

            tput cup 11 20
            echo "${BOLD}Designation :${RESET} $desg"

            tput cup 12 20
            echo "${BOLD}Department  :${RESET} $dept"

            tput cup 13 20
            echo "${BOLD}Salary      :${RESET} $sal"
        else
            tput cup 9 20
            echo "${BOLD}No record found for Employee Code: $emp_code${RESET}"
        fi
    fi

    tput cup 16 20
    echo -n "${BOLD}Do you want to continue (Y/N)...: ${RESET}"
    read view_choice
done

sh emp_file_mgmt.sh

