#!/bin/bash

clear

BOLD=$(tput bold)
RESET=$(tput sgr0)

tput cup 2 40
echo "${BOLD}*EMPLOYEE FILE MANAGEMENT SYSTEM*${RESET}"

tput cup 5 20
echo "${BOLD}1. Add employee details${RESET}"

tput cup 7 20
echo "${BOLD}2. Delete employee details${RESET}"

tput cup 9 20
echo "${BOLD}3. View employee details${RESET}"

tput cup 11 20
echo "${BOLD}4. Modify employee details${RESET}"

tput cup 13 20
echo "${BOLD}5. Return to previous menu${RESET}"

tput cup 16 20
echo -n "${BOLD}Enter Your Choice:${RESET} "

read mgmt_choice

case $mgmt_choice in
    1) sh add_record.sh ;;
    2) sh del_record.sh ;;
    3) sh view_record.sh ;;
    4) sh modify_record.sh ;;
    5) sh Main_Menu.sh ;;
    *) echo "Invalid choice, try again.." ;;
esac

