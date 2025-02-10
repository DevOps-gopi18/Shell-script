#!/bin/bash

USERID=$(id -u)

#colours
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/expense-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATION(){
    if [ $1 -ne 0 ]
    then
        echo "$2... FAILURE"
        exit 1
    else
        echo "$2 .... SUCCESS"
    fi
}

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R ERROR : You must have root access to execute the program $N"
        exit 1
    fi
}

echo "script execution started at : $TIMESTAMP" &>>$LOG_FILE_NAME

CHECK_ROOT

dnf install nginx -y &>>$LOG_FILE_NAME
VALIDATION $? "Installing nginx"

systemctl enable nginx &>>$LOG_FILE_NAME
VALIDATION $? "Enable nginx"

systemctl start nginx &>>$LOG_FILE_NAME
VALIDATION $? "Start nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE_NAME
VALIDATION $? "Removing default content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE_NAME
VALIDATION $? "Downloading latest code"

cd /usr/share/nginx/html
VALIDATION $? "Moving to html directory"

unzip /tmp/frontend.zip &>>$LOG_FILE_NAME
VALIDATION $? "unzip frontend"

cp /root/Shell-script/shell-expense/expense.conf /etc/nginx/default.d/expense.conf &>>$LOG_FILE_NAME
VALIDATION $? "copied expense config"

systemctl restart nginx &>>$LOG_FILE_NAME
VALIDATION $? "Restarting nginx"
