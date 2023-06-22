echo -e "\e[32m Installing Nginx \e[0m"
yum install nginx -y &>>/tmp/logfile

echo -e "\e[32m Removing Default page \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/logfile

echo -e "\e[32m Downloading package \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/logfile

echo -e "\e[32m Extracting Frontend package \e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>/tmp/logfile

echo -e "\e[32m Updating Configuration File \e[0m"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/logfile

echo -e "\e[32m Starting Nginx Service \e[0m"
systemctl enable nginx &>>/tmp/logfile
systemctl restart nginx &>>/tmp/logfile