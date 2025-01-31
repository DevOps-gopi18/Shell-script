#!/bin/bash


USERID=$(id -u)
R="\e[31m]"
G="\e[32m"
Y="\e[33m"
W="\e[0m"
B="\e[44m"

LOG_FOLDER="/var/log/shellscript-log"
FILE_NAME=$( echo $0 | cut -d "." -f1)
TIMESTAMP=$( date +%Y-%m-%D-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$FILE_NAME-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 installation ...$R FAILED $W"
        exit 1
    else
        echo -e "$2 installtion ...$G SUCCESS! $W"
    fi
}

echo "script execution started at :$LOG_FILE_NAME" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
    echo "ERROR : You must have root access to execute the program"
    exit 1
fi

dnf list installed git &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing Git" &>>$LOG_FILE_NAME
else
    echo -e "$B GIT already ...  Installed $W"
fi

dnf list installed mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
    dnf install mysql -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing MySql"
else
    echo -e "mysql already ...$Y Installed $W"
fi

