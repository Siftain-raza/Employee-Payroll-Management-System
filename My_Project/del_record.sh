#!/bin/bash

clear

BOLD=$(tput bold)
RESET=$(tput sgr0)

del_choice='Y'

while [ "$del_choice" = "y" -o "$del_choice" = "Y" ]
do
    if [ ! -f EMP_DBF ]
    then
        clear
        tput cup 5 30
        echo "${BOLD}NO RECORD EXISTS.${RESET}"

        tput cup 7 30
        echo -n "${BOLD}Press ENTER key to continue.....${RESET}"
        read key
        sh emp_file_mgmt.sh
    else
        clear

        # Title
        tput cup 2 40
        echo "${BOLD}MENU FOR DELETING RECORD${RESET}"

        # Prompt
        tput cup 6 20
        echo -n "${BOLD}Enter Employee Code to delete: ${RESET}"
        read emp_code

        if grep -q "^$emp_code:" EMP_DBF
        then
            grep -v "^$emp_code:" EMP_DBF > del_temp
            mv del_temp EMP_DBF
            tput cup 9 20
            echo "${BOLD}Record Successfully Deleted...!${RESET}"
        else
            tput cup 9 20
            echo "${BOLD}Record Not Found..!${RESET}"
        fi

        tput cup 12 20
        echo -n "${BOLD}Do you want to continue (Y/N)...: ${RESET}"
        read del_choice
    fi
done

sh emp_file_mgmt.sh

