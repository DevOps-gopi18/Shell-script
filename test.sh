#!/bin/bash

TIMESTAMP=$(date)

echo "print the time... $TIMESTAMP"

#multiplying 2 numbers

NUMBER1=$1
NUMBER2=$2

SUM=$((NUMBER1*NUMBER2))

echo "The values are....$SUM"

CINEMA=("Devara" "Pushpa" "RRR")

echo "First occurence of the movie is ${CINEMA[0]}"
echo "Second occurence of the movie is ${CINEMA[1]}"
echo "Third occurence of the movie is ${CINEMA[2]}"

echo "All occureses...${CINEMA[@]}"