#!/bin/bash

# -gt -lt -eq -ge -le
# -gt = greater than
# -lt = less than
# -eq = equal
# -ge = greater than or equal
# -le = less than or equal

#Given number is greater than(100)?

NUMBER=$1

if [ $NUMBER -gt 100 ]
then
    echo "Given number is grater than 100"
else
    echo "Given number is less than 100"
fi