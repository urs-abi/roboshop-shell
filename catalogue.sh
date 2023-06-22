echo -e "\e[32m Downloading NodeJs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m Installing NodeJs \e[0m"
yum install nodejs -y

echo -e "\e[32m Adding Application User \e[0m"
useradd roboshop

echo -e "\e[32m Creating Application Directory \e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[32m Downloading Catalogue Package \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 

echo -e "\e[32m Extracting Catalogue Package \e[0m"
cd /app 
unzip /tmp/catalogue.zip

echo -e "\e[32m Downloading Dependencies \e[0m"
cd /app 
npm install 

echo -e "\e[32m Creating Catalouge Service File \e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[32m Starting Catalouge Service \e[0m"
systemctl daemon-reload
systemctl enable catalogue 
systemctl restart catalogue

echo -e "\e[32m Creating MongoDB Repo \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m Installling MongoDB CLient \e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32m Loading Schema \e[0m"
mongo --host mongodb-dev.devops1289.site </app/schema/catalogue.js