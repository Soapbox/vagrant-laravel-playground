# sudo hostname vlplayground.vagrant

echo " ------------ Running apt-get update... ------------ "
sudo apt-get update

# Set MySQL password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# PHP and Apache
if [[ -z "$LAMP_INSTALLED" ]]; then

	echo " ------------ Installing Libraries... ------------ "

	sudo apt-get install -y vim curl python-software-properties
	sudo add-apt-repository -y ppa:ondrej/php5
	sudo apt-get update

	sudo apt-get install -y --fix-missing php5 apache2 libapache2-mod-php5 \
	  php5-curl php5-gd php5-mcrypt php5-readline mysql-server-5.5 php5-mysql \
	  git-core php5-xdebug

# xdebug setup
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
xdebug.idekey = "vagrant"
xdebug.remote_enable = 1
xdebug.remote_autostart = 0
xdebug.remote_port = 9000
xdebug.remote_handler=dbgp
xdebug.remote_log="/var/log/xdebug/xdebug.log"
xdebug.remote_host=10.0.2.2
EOF

	echo "export LAMP_INSTALLED=true" >> /etc/profile

fi



# Apache/MySQL configuration

if [[ -z "$SERVER_CONFIGURED" ]]; then

	echo " ------------ Configuring Apache... ------------ "

	sudo a2enmod rewrite

	# Always show all errors
	sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
	sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
	sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini


	# Adds ability to connect to the MySQL server from the host machine
	# http://stackoverflow.com/questions/16954395/how-to-connect-to-a-mysql-server-running-on-a-virtual-machine
	sudo sed -i "s/^[#\s]*bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

	# Prevent max-connection errors
	sudo sed -i "s/^[#\s]*max_connections\s*=.*/max_connections = 1024/" /etc/mysql/my.cnf
	if [[ `cat /etc/mysql/my.cnf | grep max_connect_errors` = '' ]]; then
		sudo bash -c 'echo "max_connect_errors = 1024" >> /etc/mysql/my.cnf'
	else
		sudo sed -i "s/^[#\s]*max_connect_errors\s*=.*/max_connect_errors = 1024/" /etc/mysql/my.cnf
	fi

	# See Jeffrey Way's "Stop using MAMP" Laracast
	sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
	sudo sed -i "s/DocumentRoot .*/DocumentRoot \/var\/www\/public/" /etc/apache2/sites-available/000-default.conf

	# Add vlplayground database
	mysql -u root -proot < /var/www/setup.sql

	sudo service apache2 restart
	sudo /etc/init.d/mysql restart

	echo "export SERVER_CONFIGURED=true" >> /etc/profile

fi

# Install composer

if [[ -z "$COMPOSER_INSTALLED" ]]; then

	echo " ------------ Installing Composer... ------------ "

	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
	echo "export COMPOSER_INSTALLED=true" >> /etc/profile
fi

# HHVM for super-fast PHP Commands
# https://github.com/facebook/hhvm/wiki/Building-and-installing-HHVM-on-Ubuntu-12.04

if [[ -z "$HHVM_INSTALLED" ]]; then

	echo " ------------ Installing HHVM... ------------ "

	sudo add-apt-repository -y ppa:mapnik/boost
	wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
	echo deb http://dl.hhvm.com/ubuntu precise main | sudo tee /etc/apt/sources.list.d/hhvm.list
	sudo apt-get update
	sudo apt-get install -y hhvm
	echo "export HHVM_INSTALLED=true" >> /etc/profile

fi

# Get rid of existing html folder
sudo rm -rf /var/www/html
source /etc/profile
