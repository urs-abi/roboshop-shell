echo -e "\e[32m Installing GoLang \e[0m"
yum install golang -y &>>/tmp/logfile

echo -e "\e[32m Adding Application User \e[0m"
useradd roboshop &>>/tmp/logfile

echo -e "\e[32m Creating Application Directory \e[0m"
rm -rf /app &>>/tmp/logfile
mkdir /app &>>/tmp/logfile

echo -e "\e[32m Downloading Dispatch Package \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/logfile

echo -e "\e[32m Extracting Dispatch Package \e[0m"
cd /app 
unzip /tmp/dispatch.zip &>>/tmp/logfile

echo -e "\e[32m Downloading Dependencies \e[0m"
cd /app 
go mod init dispatch &>>/tmp/logfile
go get &>>/tmp/logfile
go build &>>/tmp/logfile

echo -e "\e[32m Creating Dispatch Service File \e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/logfile

echo -e "\e[32m Starting Dispatch Service \e[0m"
systemctl daemon-reload &>>/tmp/logfile
systemctl enable dispatch &>>/tmp/logfile
systemctl restart dispatch &>>/tmp/logfile