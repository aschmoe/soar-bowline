#!/bin/bash -e

export PATH=$HOME/bin:$PATH

# Create required directories just in case.
mkdir -p /var/www/docroot /var/www/logs
echo "*" > /var/www/logs/.gitignore

# Use project's drush if exists.
if [[ -e /var/www/vender/drush ]]; then
  export DRUSH="/var/www/vendor/drush/drush/drush"
  ln -s $DRUSH /usr/local/bin/drush
fi

# Set the apache user and group to match the host user.
OWNER=$(stat -c '%u' /var/www)
GROUP=$(stat -c '%g' /var/www)
usermod -o -u $OWNER www-data
groupmod -o -g $GROUP www-data
echo Using the following user for running apache:
id www-data

/etc/apache2/foreground.sh
