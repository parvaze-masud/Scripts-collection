#### CentOs 7#####

[mas@DB-node ~]$ wget https://dev.mysql.com/get/mysql80-community-release-el7-10.noarch.rpm

[mas@DB-node ~]$ sudo yum localinstall mysql80-community-release-el7-10.noarch.rpm

[mas@DB-node ~]$ sudo yum repolist enabled | grep "mysql.*-community.*"

[mas@DB-node yum.repos.d]$ cd /etc/yum.repos.d/

[mas@DB-node yum.repos.d]$ sudo vim mysql-community.repo

[mas@DB-node yum.repos.d]$ yum repolist

[mas@DB-node yum.repos.d]$ sudo yum install mysql-community-server

[mas@DB-node yum.repos.d]$ sudo systemctl enable mysqld

[mas@DB-node yum.repos.d]$ sudo systemctl start mysqld

[mas@DB-node yum.repos.d]$ mysql -V

[mas@DB-node yum.repos.d]$ sudo grep "A temporary password" /var/log/mysqld.log | tail
t*&%rhEw#6dt

[mas@DB-node yum.repos.d]$ sudo mysql_secure_installation
Password: PRG@1qaz (root)

[mas@DB-node yum.repos.d]$ mysql -u root -p

mysql> CREATE DATABASE forum;

mysql> CREATE USER 'forum'@'%' IDENTIFIED BY 'PRG@1qaz';

mysql> GRANT ALL PRIVILEGES ON forum.* TO 'forum'@'%';

mysql> FLUSH PRIVILEGES;

#Firewall enable

sudo firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=192.168.43.94 port port=3306 protocol=tcp accept'
sudo firewall-cmd --reload
sudo firewall-cmd --list-all





