echo -e "\e[32m Installing Python \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/logfile

echo -e "\e[32m Adding Application User \e[0m"
useradd roboshop &>>/tmp/logfile

echo -e "\e[32m Creating Application Directory \e[0m"
rm -rf /app &>>/tmp/logfile
mkdir /app &>>/tmp/logfile

echo -e "\e[32m Downloading Payment Package \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/logfile

echo -e "\e[32m Extracting Payment Package \e[0m"
cd /app 
unzip /tmp/payment.zip &>>/tmp/logfile

echo -e "\e[32m Downloading Dependencies \e[0m"
cd /app 
pip3.6 install -r requirements.txt &>>/tmp/logfile

echo -e "\e[32m Creating Payment Service File \e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/logfile

echo -e "\e[32m Starting Payment Service \e[0m"
systemctl daemon-reload &>>/tmp/logfile
systemctl enable payment &>>/tmp/logfile
systemctl restart payment &>>/tmp/logfile