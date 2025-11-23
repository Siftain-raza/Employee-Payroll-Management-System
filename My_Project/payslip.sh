#!/bin/bash

BOLD=$(tput bold)
RESET=$(tput sgr0)

choice="Y"

# Center a line of text
center_text() {
    local text="$1"
    local cols
    cols=$(tput cols)
    local width=${#text}
    local pad=$(( (cols - width) / 2 ))
    printf "%*s%s\n" $pad "" "$text"
}

# Animated center text
center_text_anim() {
    center_text "$1"
    sleep 0.02   # animation delay
}

while [ "$choice" = "y" -o "$choice" = "Y" ]
do
    if [ ! -f EMP_DBF ] || [ ! -s EMP_DBF ]
    then
        clear
        tput cup 5 25
        echo "${BOLD}NO FILE EXISTS.${RESET}"

        tput cup 7 25
        echo -n "${BOLD}Press ENTER key to continue.....${RESET}"
        read key
        sh emp_payroll.sh
        exit
    else
        clear
        cols=$(tput cols)

        tput cup 2 35
        echo "${BOLD}EMPLOYEE PAYSLIP GENERATION${RESET}"

        tput cup 5 20
        echo -n "${BOLD}Enter Employee Code:${RESET} "
        read emp_code

        record=$(grep "^$emp_code:" EMP_DBF)

        if [ -z "$record" ]
        then
            tput cup 8 20
            echo "${BOLD}Employee Not Found!${RESET}"

            tput cup 10 20
            echo -n "${BOLD}Do you want to try another employee code? (Y/N): ${RESET}"
            read choice

            if [ "$choice" = "y" -o "$choice" = "Y" ]
            then
                continue
            else
                break
            fi
        fi

        emp_name=$(echo "$record" | cut -d: -f2)
        emp_bas_sal=$(echo "$record" | cut -d: -f5)

        hra=$(( emp_bas_sal * 30 / 100 ))
        da=$(( emp_bas_sal * 90 / 100 ))
        cca=300
        proftax=200
        pf=$(( (emp_bas_sal + da) * 12 / 100 ))

        tput cup 7 20
        echo -n "${BOLD}Enter Extra Allowance:${RESET} "
        read extra

        total_income=$(( emp_bas_sal + hra + da + cca + extra ))
        total_deduction=$(( proftax + pf ))
        net_salary=$(( total_income - total_deduction ))

        # Print payslip with animation
        clear
        cols=$(tput cols)
        indent=$(( (cols - 70) / 2 ))

        center_text_anim "------------------------------------------------------------------------"
        center_text_anim "                        ${BOLD}🧾EMPLOYEE PAY SLIP🧾${RESET}            "
        center_text_anim "------------------------------------------------------------------------"
        echo ""
        center_text_anim "Employee Code : $emp_code"
        center_text_anim "Employee Name : $emp_name"
        echo ""
        center_text_anim "------------------------------------------------------------------------"
        center_text_anim "     *INCOME DETAILS*                 |         *DEDUCTION DETAILS*     "
        center_text_anim "------------------------------------------------------------------------"

        printf "%*s%-25s %-10s | %-25s %-10s\n" $indent "" \
            "BASIC SALARY :" "₹$emp_bas_sal" "PROFESSIONAL TAX :" "₹$proftax"
        sleep 0.02
        printf "%*s%-25s %-10s | %-25s %-10s\n" $indent "" \
            "HRA (30%) :" "₹$hra" "PROVIDENT FUND (12%) :" "₹$pf"
        sleep 0.02
        printf "%*s%-25s %-10s | %-25s %-10s\n" $indent "" \
            "DA (90%) :" "₹$da" "" ""
        sleep 0.02
        printf "%*s%-25s %-10s | %-25s %-10s\n" $indent "" \
            "CCA (Fixed) :" "₹$cca" "" ""
        sleep 0.02
        printf "%*s%-25s %-10s | %-25s %-10s\n" $indent "" \
            "Extra Allowance :" "₹$extra" "" ""
        sleep 0.02

        center_text_anim "------------------------------------------------------------------------"
        printf "%*s%-25s %-10s | %-25s %-10s\n" $indent "" \
            "TOTAL INCOME :" "₹$total_income" "TOTAL DEDUCTION :" "₹$total_deduction"
        sleep 0.02
        center_text_anim "------------------------------------------------------------------------"
        center_text_anim "💰NET TAKE HOME SALARY : ₹$net_salary💰"
        center_text_anim "------------------------------------------------------------------------"
    fi

    echo ""
    echo -n "${BOLD}Do you want to continue (Y/N).....${RESET} "
    read choice
done

sh emp_payroll.sh

