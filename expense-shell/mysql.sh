#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
P="\e[35m"

echo "Please enter DB password:"
read -s mysql_root_password


VALIDATE(){
   if [ $1 -ne 0 ]
   then
       echo -e "$2...$R FAILURE $N"
       exit 1
    else
        echo -e "$2...$G SUCCESS $N"   
    fi   

}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1  # manually exit if error comes.
else
    echo "you are super user."    
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing Mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling Mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting Mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "Setting up root password"

 #    use up code or down code

#mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
   #  VALIDATE $? "MySQL Root password Setup"


 mysql -h db.venkymadhumanchi.shop -uroot -p${mysql_root_password} -e 'SHOW DATABASES;' &>>$LOGFILE
  if [ $? -ne 0 ]
  then
     mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
     VALIDATE $? "MySQL Root password Setup"
  else
     echo -e "MySQL Root password is already setup...$P SKIPPING $N"
  fi        


