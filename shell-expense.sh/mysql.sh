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
    if [ $1 -ne 0]
    then
        echo "$2... FAILURE"
        exit 1
    else
        echo "$2 .... SUCCESS"
    fi
}

CHECK_ROOT(){
    if [ $USERID -ne 0]
    then
        echo -e "$R ERROR : You must have root access to execute the program $N"
        exit 1
    fi
}

echo "script execution started at : $TIMESTAMP" &>>$LOG_FILE_NAME

CHECK_ROOT

dnf install mysql-server -y &>>$LOG_FILE_NAME
VALIDATION $? "Installing MySQL server"

systemctl enable mysqld &>>$LOG_FILE_NAME
VALIDATE $? "Enabling MySQL server"

systemctl start mysqld &>>$LOG_FILE_NAME
VALIDATE $? "Starting MySQL server"

mysql -h 172.31.43.235 -u root -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE_NAME

if [ S? -ne 0]
then
    echo "MySQL root password not setup" &>>$LOG_FILE_NAME
    mysql_secure_installation --set-root-pass ExpenseApp@1
    VALIDATE $? "setting root password"
else
    echo -e "MySQL root password already setup...$Y SKIPPING $N"
fi

# dnf list installed mysql

# if [ $? -ne 0]
# then
#     dnf install mysql -y
#     if [ $? -ne 0]
#     then
#         echo "Install MySql....FAILURE"
#         exit 1
#     else
#         echo "Install MySql...SUCCESS"
#         exit 1
#     fi
# else
#     echo "MySQL is already ...INSTALLED"
# fi 