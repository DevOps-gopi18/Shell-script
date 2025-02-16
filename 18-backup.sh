#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOUR_DIR=$1
DEST_DIR=$2
DAYS=${ 3:-14 } # if user is not providing number of days, we are taking 14 as default

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

USAGE(){
    echo -e "$R USAGE :: $N sh 18-backup.sh <SOUR_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p /var/log/shellscript-logs

if [ $# -lt 2 ]
then
    USAGE
fi


if[ ! -d "$SOUR_DIR"]
then
    echo -e "$SOUR_DIR $Y Does not exist...please check $N"
    exit 1
fi

if[ ! -d "$DEST_DIR"]
then
    echo -e "$DEST_DIR $Y Does not exist...please check $N"
    exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES=$(find $SOUR_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ] # true if there are files to zip
then
    echo "Files are : $FILES "
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOUR_DIR -name ".log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "successfully created the zip files for the older than $DAYS"
        while read -r filepath # here filepath is the variable name, you can give any name
        do
            echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
            rm -rf $filepath
            echo "Deleting file: $filepath"
        done <<<$FILES
    else
        echo -e "$R error ::$N failed to creat zip file"
        exit 1
    fi
else
    echo "No files are found older than $DAYS"
fi
