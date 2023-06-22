echo -e "\e[32m Downloading NodeJs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/logfile


echo -e "\e[32m Installing NodeJs \e[0m"
yum install nodejs -y &>>/tmp/logfile


echo -e "\e[32m Adding Application User \e[0m"
useradd roboshop

echo -e "\e[32m Creating Application Directory \e[0m"
rm -rf /app &>>/tmp/logfile
mkdir /app &>>/tmp/logfile

echo -e "\e[32m Downloading Catalogue Package \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/logfile

echo -e "\e[32m Extracting Catalogue Package \e[0m"
cd /app 
unzip /tmp/catalogue.zip &>>/tmp/logfile

echo -e "\e[32m Downloading Dependencies \e[0m"
cd /app 
npm install &>>/tmp/logfile

echo -e "\e[32m Creating Catalouge Service File \e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/logfile

echo -e "\e[32m Starting Catalouge Service \e[0m"
systemctl daemon-reload &>>/tmp/logfile
systemctl enable catalogue &>>/tmp/logfile
systemctl restart catalogue &>>/tmp/logfile

echo -e "\e[32m Creating MongoDB Repo \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/logfile

echo -e "\e[32m Installling MongoDB CLient \e[0m"
yum install mongodb-org-shell -y &>>/tmp/logfile

echo -e "\e[32m Loading Schema \e[0m"
mongo --host mongodb-dev.devops1289.site </app/schema/catalogue.js &>>/tmp/logfile