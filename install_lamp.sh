#!/bin/bash

# author: Martin Clauß - mc@informatik.uni-leipzig.de
# created: July 14 2013

# This script is based on this tutorial: http://community.linuxmint.com/tutorial/view/486

if [[ $UID -ne 0 ]];
then
	echo "You must be root to run this script. Exiting..."
	exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "********************************"
echo "    LAMP installation script"
echo "********************************"
read -s -p "> MySQL root password: " mysqlpass

apt-get -y install apache2

if ! wget -q "http://localhost"
then
	echo "Apache not running. Exiting..."
	exit 1
fi

apt-get -y install php5 libapache2-mod-php5

/etc/init.d/apache2 restart

echo "<?php phpinfo(); ?>" > /var/www/__test__.php

if ! wget -q "http://localhost/__test__.php"
then
	echo "Cannot open __test__.php. Exiting..."
	rm /var/www/__test__.php
	exit 1
else
	if [[ $(wget -q -O - "http://localhost/__test__.php" | grep -i php) == "" ]]
	then
		echo "PHP is not running correctly. Exiting..."
		rm /var/www/__test__.php
		exit 1
	fi
fi

rm /var/www/__test__.php

debconf-set-selections <<< "mysql-server mysql-server/root_password $mysqlpass"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again $mysqlpass"

apt-get -y install mysql-server

# password will be set during the mysql-server installation

apt-get -y install libapache2-mod-auth-mysql php5-mysql phpmyadmin

sed -i "s/;extension=mysql.so/extension=mysql.so/" /etc/php5/apache2/php.ini

/etc/init.d/apache2 restart

if [[ $(grep -i "Include /etc/phpmyadmin/apache.conf" /etc/apache2/apache2.conf) == "" ]]
then
	echo -e "\nInclude /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
fi

if ! wget -q "http://localhost/phpmyadmin"
then
	echo "phpmyadmin is not running. Exiting..."
	exit 1
fi

echo "Installation complete :)"