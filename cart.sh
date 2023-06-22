echo -e "\e[32m Downloading NodeJs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/logfile


echo -e "\e[32m Installing NodeJs \e[0m"
yum install nodejs -y &>>/tmp/logfile


echo -e "\e[32m Adding Application User \e[0m"
cartadd roboshop &>>/tmp/logfile

echo -e "\e[32m Creating Application Directory \e[0m"
rm -rf /app &>>/tmp/logfile
mkdir /app &>>/tmp/logfile

echo -e "\e[32m Downloading Cart Package \e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/logfile

echo -e "\e[32m Extracting Cart Package \e[0m"
cd /app 
unzip /tmp/cart.zip &>>/tmp/logfile

echo -e "\e[32m Downloading Dependencies \e[0m"
cd /app 
npm install &>>/tmp/logfile

echo -e "\e[32m Creating Cart Service File \e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/logfile

echo -e "\e[32m Starting Cart Service \e[0m"
systemctl daemon-reload &>>/tmp/logfile
systemctl enable cart &>>/tmp/logfile
systemctl restart cart &>>/tmp/logfile