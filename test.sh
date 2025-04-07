#!/bin/bash

TIMESTAMP=$(date)

echo "print the time... $TIMESTAMP"

#multiplying 2 numbers

NUMBER1=$1
NUMBER2=$2

SUM=$((NUMBER1*NUMBER2))

echo "The values are....$SUM"