echo -e "\e[32m Downloading Repos for Erlang \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/logfile

echo -e "\e[32m Downloading Repos for RabbitMQ \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/logfile

echo -e "\e[32m Installing RabbitMQ \e[0m"
yum install rabbitmq-server -y &>>/tmp/logfile

echo -e "\e[32m Starting RabbitMQ Service \e[0m"
systemctl enable rabbitmq-server &>>/tmp/logfile
systemctl restart rabbitmq-server &>>/tmp/logfile

echo -e "\e[32m Configuring Application User \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/logfile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/logfile