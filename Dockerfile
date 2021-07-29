
FROM ubuntu

RUN apt-get update \
    && apt-get install software-properties-common -y \
    && add-apt-repository ppa:ondrej/php -y \
    && apt-get install php8.0 php8.0-dev php8.0-xml -y --allow-unauthenticated -y \
    && apt-get install unixodbc-dev -y \
    && pecl install sqlsrv pdo_sqlsrv

RUN echo "; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.0/mods-available/sqlsrv.ini \
	&& echo "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.0/mods-available/pdo_sqlsrv.ini \
    && apt-get install -y libapache2-mod-php8.0 apache2 \
    && a2dismod mpm_event \
    && a2enmod mpm_prefork \
    && a2enmod php8.0 \
    && phpenmod -v 8.0 sqlsrv pdo_sqlsrv \
    && service apache2 restart \
    && apt-get install git -y \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD sh

# apt-get install php8.0-mbstring
# apt-get install zip unzip php8.0-zip 
# apt-get install php$PHP_VERSION-json php$PHP_VERSION-curl php$PHP_VERSION-gd php$PHP_VERSION-ldap php$PHP_VERSION-mbstring php$PHP_VERSION-bcmath php$PHP_VERSION-sqlite3 php$PHP_VERSION-zip php$PHP_VERSION-intl 
