#!/bin/bash

clear

BOLD=$(tput bold)
RESET=$(tput sgr0)

add_choice='Y'

while [ "$add_choice" = "y" -o "$add_choice" = "Y" ]
do
    if [ -f EMP_DBF ]
    then
        last_emp_code=$(tail -n 1 EMP_DBF | cut -d ":" -f1)
        new_emp_code=$(( last_emp_code + 1 ))
    else
        new_emp_code=1
    fi

    clear

    # Title
    tput cup 2 40
    echo "${BOLD}*MENU FOR ADDING EMPLOYEE RECORD*${RESET}"

    tput cup 6 20
    echo "${BOLD}Employee Code = $new_emp_code${RESET}"

    tput cup 8 20
    echo -n "${BOLD}Enter Employee Name: ${RESET}"
    read emp_name

    tput cup 10 20
    echo -n "${BOLD}Enter Employee Designation: ${RESET}"
    read emp_desg

    tput cup 12 20
    echo -n "${BOLD}Enter Employee Department: ${RESET}"
    read emp_dept

    tput cup 14 20
    echo -n "${BOLD}Enter Employee Basic Salary: ${RESET}"
    read emp_bas_sal

    # Save record
    echo "$new_emp_code:$emp_name:$emp_desg:$emp_dept:$emp_bas_sal" >> EMP_DBF

    tput cup 16 20 
    echo "${BOLD}Record Successfully Inserted....!${RESET}"
    tput cup 18 20
    echo -n "${BOLD}Do you want to continue (Y/N)...: ${RESET}"
    read add_choice
done

sh emp_file_mgmt.sh

