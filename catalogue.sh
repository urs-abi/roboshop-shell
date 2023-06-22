echo -e "\e[32m Downloading NodeJs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd roboshop

rm -rf /app
mkdir /app 

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 

cd /app 
unzip /tmp/catalogue.zip

cd /app 
npm install 

cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload
systemctl enable catalogue 
systemctl restart catalogue
