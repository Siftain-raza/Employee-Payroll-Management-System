#!/bin/bash

EMP_DBF="EMP_DBF"

clear
BOLD=$(tput bold)
RESET=$(tput sgr0)

tput cup 2 40
echo "${BOLD}MENU FOR MODIFYING EMPLOYEE RECORD${RESET}"

if [ ! -f "$EMP_DBF" ] || [ ! -s "$EMP_DBF" ]
then
    tput cup 5 30
    echo "${BOLD}NO FILE EXISTS.${RESET}"

    tput cup 7 30
    echo -n "${BOLD}Press ENTER key to continue.....${RESET}"
    read key
    sh emp_file_mgmt.sh
    exit
fi

while true
do
    tput cup 6 20
    echo -n "${BOLD}Enter Employee Code to Modify:${RESET} "
    read emp_code

    if grep -q "^$emp_code:" "$EMP_DBF"
    then
        break
    else
        tput cup 8 20
        echo "${BOLD}Record Not Found..!${RESET}"

        tput cup 10 20
        echo -n "${BOLD}Do you want to try another code? (Y/N):${RESET} "
        read choice

        if [ "$choice" = "y" -o "$choice" = "Y" ]
        then
            clear
            tput cup 2 40
            echo "${BOLD}MENU FOR MODIFYING EMPLOYEE RECORD${RESET}"
            continue
        else
            sh emp_file_mgmt.sh
            exit
        fi
    fi
done

old_record=$(grep "^$emp_code:" "$EMP_DBF")
old_name=$(echo "$old_record" | cut -d: -f2)
old_desg=$(echo "$old_record" | cut -d: -f3)
old_dept=$(echo "$old_record" | cut -d: -f4)
old_sal=$(echo "$old_record" | cut -d: -f5)

clear
tput cup 2 40
echo "${BOLD}MODIFYING RECORD FOR EMPLOYEE CODE: $emp_code${RESET}"

tput cup 5 20
echo "${BOLD}Employee Name :${RESET} $old_name (Cannot Modify)"

tput cup 7 20
echo -n "${BOLD}New Designation [$old_desg]: ${RESET}"
read emp_desg
emp_desg=${emp_desg:-$old_desg}

tput cup 9 20
echo -n "${BOLD}New Department [$old_dept]: ${RESET}"
read emp_dept
emp_dept=${emp_dept:-$old_dept}

tput cup 11 20
echo -n "${BOLD}New Basic Salary [$old_sal]: ${RESET}"
read emp_bas_sal
emp_bas_sal=${emp_bas_sal:-$old_sal}

new_record="$emp_code:$old_name:$emp_desg:$emp_dept:$emp_bas_sal"

awk -F: -v code="$emp_code" -v newrec="$new_record" 'BEGIN{OFS=FS}
{
    if ($1==code)
        print newrec
    else
        print $0
}' "$EMP_DBF" > temp_emp && mv temp_emp "$EMP_DBF"

tput cup 13 20
echo "${BOLD}Record Modified Successfully..!${RESET}"

tput cup 15 20
echo -n "${BOLD}Modify another record? (Y/N): ${RESET}"
read choice

if [ "$choice" = "y" -o "$choice" = "Y" ]
then
    sh modify_record.sh
else
    sh emp_file_mgmt.sh
fi

