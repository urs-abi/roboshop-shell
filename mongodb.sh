cp mongodb.repo /etc/yum.repos.d/mongodb.repo

yum install mongodb-org -y 

## Modify config file

systemctl enable mongod

systemctl start mongod