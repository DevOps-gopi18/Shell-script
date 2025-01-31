#!/bin/bash


USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 installation ...FAILED"
        exit 1
    else
        echo "$2 installtion ...SUCCESS!"
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
    echo "GIT already ...installed"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "Installing MySql"
else
    echo "mysql already ...installed"
fi

