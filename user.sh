echo -e "\e[32m Downloading NodeJs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/logfile


echo -e "\e[32m Installing NodeJs \e[0m"
yum install nodejs -y &>>/tmp/logfile


echo -e "\e[32m Adding Application User \e[0m"
useradd roboshop &>>/tmp/logfile

echo -e "\e[32m Creating Application Directory \e[0m"
rm -rf /app &>>/tmp/logfile
mkdir /app &>>/tmp/logfile

echo -e "\e[32m Downloading user Package \e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/logfile

echo -e "\e[32m Extracting user Package \e[0m"
cd /app 
unzip /tmp/user.zip &>>/tmp/logfile

echo -e "\e[32m Downloading Dependencies \e[0m"
cd /app 
npm install &>>/tmp/logfile

echo -e "\e[32m Creating User Service File \e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/logfile

echo -e "\e[32m Starting User Service \e[0m"
systemctl daemon-reload &>>/tmp/logfile
systemctl enable user &>>/tmp/logfile
systemctl restart user &>>/tmp/logfile

echo -e "\e[32m Creating MongoDB Repo \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/logfile

echo -e "\e[32m Installling MongoDB CLient \e[0m"
yum install mongodb-org-shell -y &>>/tmp/logfile

echo -e "\e[32m Loading Schema \e[0m"
mongo --host mongodb-dev.devops1289.site </app/schema/user.js &>>/tmp/logfile