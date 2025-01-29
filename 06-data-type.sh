#!/bin/bash

TIMESTAMP=$(date) #time variable

echo "script executed at :$TIMESTAMP" # printing the time

#adding 2 numbers
NUMBER1=$1
NUMBER2=$2

SUM=$((NUMBER1+NUMBER2)) #ADDING NUMBERS