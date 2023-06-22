echo -e "\e[32m Creating MongoDB Repo File \e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/logfile

echo -e "\e[32m Installing MongoDB \e[0m"
yum install mongodb-org -y &>>/tmp/logfile

echo -e "\e[32m Mondifying MongoDB Conf File \e[0m"
sed -i ‘s/127.0.0.1/0.0.0.0/’ /etc/mongo.conf

echo -e "\e[32m Starting MongoDB Service \e[0m"
systemctl enable mongod &>>/tmp/logfile

systemctl restart mongod &>>/tmp/logfile