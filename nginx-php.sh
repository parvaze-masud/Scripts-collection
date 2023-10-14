##############Install Nginx:########################

sudo yum install yum-utils

################Add nginx repos:#########################

sudo vim /etc/yum.repos.d/nginx.repo

#################################################################################################
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
#############################################################################################

sudo yum-config-manager --enable nginx-mainline
sudo yum install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx

##########Firewall Eanble#####################

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

####Install PHP 7.4:#######################

sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
cd /etc/yum.repos.d/
sudo vim remi-php74.repo        # or edit file to enable 7.4 (recommended)
sudo yum-config-manager --enable remi-php74.repo  #command to enable 7.4 (not recommended)

#############################################################################################################
[remi-php74]
name=Remi's PHP 7.4 RPM repository for Enterprise Linux 7 - $basearch
#baseurl=http://rpms.remirepo.net/enterprise/7/php74/$basearch/
#mirrorlist=https://rpms.remirepo.net/enterprise/7/php74/httpsmirror
mirrorlist=http://cdn.remirepo.net/enterprise/7/php74/mirror
enabled=1      #change 0 to 1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi

[remi-php74-debuginfo]
name=Remi's PHP 7.4 RPM repository for Enterprise Linux 7 - $basearch - debuginfo
baseurl=http://rpms.remirepo.net/enterprise/7/debug-php74/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi
###############################################################################################################
sudo yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql php-xml php-pdo php-xmlrpc php-imap php-devel php-mbstring php-litespeed -y
yum list installed | grep php
php -v

###################Install PHP FPM:###############################

yum install php-fpm -y
yum list installed | grep php
cd /etc/php-fpm.d
sudo vim www.conf

#############################################
#uncomment below three lines and add nginx user
listen.owner = nginx
listen.group = nginx
listen.mode = 0660
listen = /var/run/php-fpm/php-fpm.sock # Add this line end of this file
##############################################
sudo systemctl restart php-fpm

Install Composer:

cd /tmp/
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer




