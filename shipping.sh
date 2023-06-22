echo -e "\e[32m Installing Maven \e[0m"
yum install maven -y &>>/tmp/logfile

echo -e "\e[32m Adding Application User \e[0m"
useradd roboshop &>>/tmp/logfile

echo -e "\e[32m Creating Application Directory \e[0m"
rm -rf /app &>>/tmp/logfile
mkdir /app &>>/tmp/logfile

echo -e "\e[32m Downloading Shipping Package \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/logfile

echo -e "\e[32m Extracting Shipping Package \e[0m"
cd /app 
unzip /tmp/shipping.zip &>>/tmp/logfile

echo -e "\e[32m Downloading Dependencies \e[0m"
cd /app 
mvn clean package &>>/tmp/logfile
mv target/shipping-1.0.jar shipping.jar &>>/tmp/logfile 

echo -e "\e[32m Creating Shipping Service File \e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/logfile

echo -e "\e[32m Installing MySQL Client \e[0m"
yum install mysql -y &>>/tmp/logfile

echo -e "\e[32m Loading Schema \e[0m"
mysql -h mysql-dev.devops1289.site -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/logfile

echo -e "\e[32m Starting Shipping Service \e[0m"
systemctl daemon-reload &>>/tmp/logfile
systemctl enable shipping &>>/tmp/logfile
systemctl restart shipping &>>/tmp/logfile