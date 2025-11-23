#!/bin/bash

clear

BOLD=$(tput bold)
RESET=$(tput sgr0)

tput cup 2 40
echo "${BOLD}PAYROLL FILE MANAGEMENT SYSTEM${RESET}"

tput cup 6 25
echo "${BOLD}1. Payslip generation${RESET}"

tput cup 8 25
echo "${BOLD}2. Return to previous menu${RESET}"

tput cup 12 25
echo -n "${BOLD}Enter Your Choice:${RESET} "

read mgmt_choice

case $mgmt_choice in
    1) sh payslip.sh ;;
    2) sh Main_Menu.sh ;;
    *) echo "Invalid choice, try again.." ;;
esac

