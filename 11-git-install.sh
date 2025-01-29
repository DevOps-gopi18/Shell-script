#!/bin/bash

#Git instllation...
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR : You must have root access to execute the program"
    exit 1
fi

dnf list installed git

if [ $? -ne 0 ]
then
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "GIT installation ...FAILED"
        exit 1
    else
        echo "GIT installtion ...SUCCESS!"
    fi
else
    echo "GIT already ...installed"
fi
    