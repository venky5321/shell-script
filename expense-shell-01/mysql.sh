#!/bin/bash

source ./common.sh

check_root()

echo "Please enter DB password:"
read -s mysql_root_password

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


