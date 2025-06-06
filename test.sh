#!/bin/bash

# TIMESTAMP=$(date)

# echo "print the time... $TIMESTAMP"

#multiplying 2 numbers

# NUMBER1=$1
# NUMBER2=$2

# SUM=$((NUMBER1*NUMBER2))

# echo "The values are....$SUM"

# CINEMA=("Devara" "Pushpa" "RRR")

# echo "First occurence of the movie is ${CINEMA[0]}"
# echo "Second occurence of the movie is ${CINEMA[1]}"
# echo "Third occurence of the movie is ${CINEMA[2]}"

# echo "All occureses...${CINEMA[@]}"

#Given number is greater than(100)?
# NUMBER=$1

# if [ $NUMBER -gt 100 ]
# then
#     echo "given number is greater than 100"
# else
#     echo "given number is less than 100"
# fi


#Installing MySQL
# USERID=$(id -u)

# if [ $USERID -ne 0 ]
# then
#     echo "You must have root access to install MySQL...ERROR"
# fi

# dnf list installed mysql

# if [ $? -ne 0 ]
# then
#     dnf install mysql -y
#     if [ $? -ne 0 ]
#     then
#         echo "MySQL installation...FAILURE"
#         exit 1
#     else
#         echo "MySQL installation...SUCCESS"
#         exit 1
#     fi
# else
#     echo "MySQL is already installed."
# fi


#installing GIT
# USERID=$(id -u)

# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# W="\e[0m"
# B="\e[44m"

# #log
# # LOG_FOLDER="/var/log/shell-log"
# # FILE_NAME=$( echo $0 | cut -d "." -f1 )
# # TIMESTAMP=$( date +%Y-%m-%D-%H-%M-%S )
# # LOG_FILE_NAME="$LOG_FOLDER/$FILE_NAME-$TIMESTAMP.log"

# VALIDATE(){
#     if [ $1 -ne 0 ]
#     then
#         echo -e "$2 installation ...$R FAILED $W"
#         exit 1
#     else
#         echo -e "$2 installtion ...$G SUCCESS! $W"
#     fi
# }

# if [ $USERID -ne 0 ]
# then
#     echo "You must have root access to execute the program..ERROR"
# fi

# for package in $@
# do
#     dnf list installed $package 
#     if [ $? -ne 0 ]
#     then
#         dnf install $package -y 
#         VALIDATE $? "installing $package"
#     else
#         echo -e "$Y $package is already...INSTALLED $W"
#     fi
# done

#Install Nginx

# USERID=$(id -u)

# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# W="\e[0m"
# B="\e[44m"

# VALIDATE(){
# if [ $1 -ne 0 ]
#     then
#         echo -e "$2 installation...$R FAILURE $W"
#         exit 1
#     else
#         echo -e "$2 installation...$G SUCCESS $W"
#         exit 1
#     fi
# }

# if [ $USERID -ne 0 ] #checking the root access
# then
#     echo -e "$Y You must have root access to execute the script...$R ERROR $W"
# fi

# #checking if Nginx is already present or not
# dnf list installed nginx
# if [ $? -ne 0 ]
# then
#     dnf install nginx -y #installing Nginx
#     VALIDATE $? "installing nginx"
# else
#     echo -e "$Y Nginx is already...INSTALLED $W"
# fi

#DISK USAGE

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5
MSG=""

while read -r line
do
    USAGE=$( echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$( echo $line | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="High disk usage on partition: $PARTITION usage is: $USAGE \n"
    fi

done <<< $DISK_USAGE

echo -e "Message : $MSG"