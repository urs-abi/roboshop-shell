echo -e "\e[32m Installing Redis Repo \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/logfile

echo -e "\e[32m Enabling Redis 6.2 module \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/logfile

echo -e "\e[32m Installing Redis \e[0m"
yum install redis -y &>>/tmp/logfile

echo -e "\e[32m Modifying Confif File \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/logfile

echo -e "\e[32m Starting Redis Service \e[0m"
systemctl enable redis &>>/tmp/logfile
systemctl restart redis &>>/tmp/logfile