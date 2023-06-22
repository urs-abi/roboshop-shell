echo -e "\e[32m Disbaling current MySQL \e[0m"
yum module disable mysql -y 

echo -e "\e[32m Creating MySQL Repo \e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[32m Installing MySQL \e[0m"
yum install mysql-community-server -y

echo -e "\e[32m Setting Root Password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1

echo -e "\e[32m Starting MySQL Service \e[0m"
systemctl enable mysqld
systemctl start mysqld  