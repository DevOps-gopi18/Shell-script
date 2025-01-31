#!/bin/bash


USERID=$(id -u)
R="\e[31m]"
G="\e[32m"
Y="\e[33m"
W="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 installation ...$R FAILED $W"
        exit 1
    else
        echo -e "$2 installtion ...$G SUCCESS! $W"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "ERROR : You must have root access to execute the program"
    exit 1
fi

dnf list installed git

if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing Git"
else
    echo -e "GIT already ... $Y Installed $W"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "Installing MySql"
else
    echo -e "mysql already ...$Y Installed $W"
fi

