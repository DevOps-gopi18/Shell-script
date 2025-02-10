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

dnf module disable nodejs -y &>>$LOG_FILE_NAME
VALIDATION $? "Disabling existing default nodejs"

dnf module enable nodejs:20 -y &>>$LOG_FILE_NAME
VALIDATION $? "Enabling nodejs 20"

dnf install nodejs -y &>>$LOG_FILE_NAME
VALIDATION $? "Installing nodejs"

id expense
if [ $? -ne 0 ]
then
    useradd expense &>>$LOG_FILE_NAME
    VALIDATION $? "Adding expense user"
else
    echo -e "user already created...$Y SKIPPING $N"
fi

mkdir -p /app &>>$LOG_FILE_NAME
VALIDATION $? "creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE_NAME
VALIDATION $? "Downloading backend"

cd /app
rm -rf /app/*

unzip /tmp/backend.zip &>>$LOG_FILE_NAME
VALIDATION $? "unzip backend"

npm install &>>$LOG_FILE_NAME
VALIDATION $? "installing dependencies"

cp /root/Shell-script/shell-expense/backend.service /etc/systemd/system/backend.service

# Prepare MySQL Schema

dnf install mysql -y &>>$LOG_FILE_NAME
VALIDATION $? "Installing MySQL client"

mysql -h 172.31.35.21 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE_NAME
VALIDATION $? "Setting up the transactions schema and tables"

systemctl daemon-reload &>>$LOG_FILE_NAME
VALIDATION $? "Daemon-reload"

systemctl start backend &>>$LOG_FILE_NAME
VALIDATION $? "Start backend"

systemctl enable backend &>>$LOG_FILE_NAME
VALIDATION $? "Enable backend"

systemctl restart backend &>>$LOG_FILE_NAME
VALIDATION $? "Restart backend"
