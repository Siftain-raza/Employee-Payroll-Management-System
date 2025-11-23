#!/bin/bash

clear

BOLD=$(tput bold)
RESET=$(tput sgr0)

col=30   

tput cup 2 45
printf "%b* EMPLOYEE PAYROLL MANAGEMENT SYSTEM *%b" "$BOLD" "$RESET"

tput cup 5 $col
printf "%bPROJECT MAIN MENU%b" "$BOLD" "$RESET"

tput cup 8 $col
printf "%b1. FILE MANAGEMENT%b" "$BOLD" "$RESET"

tput cup 10 $col
printf "%b2. PAYROLL MANAGEMENT%b" "$BOLD" "$RESET"

tput cup 12 $col
printf "%b3. Quit%b" "$BOLD" "$RESET"

tput cup 15 $col
printf "%bEnter your choice: %b" "$BOLD" "$RESET"

read main_menu_choice
echo ""

case $main_menu_choice in
    1) sh emp_file_mgmt.sh ;;
    2) sh emp_payroll.sh ;;
    3) exit ;;
    *) echo -e "\n Invalid choice..."; sleep 1; sh Main_Menu.sh ;;
esac

