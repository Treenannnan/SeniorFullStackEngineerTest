#!/bin/bash
set -e
echo "Installing tzdata..."
apt-get update && apt-get install -y tzdata
echo "Loading timezone info into MySQL..."
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -p"$MYSQL_ROOT_PASSWORD" mysql
