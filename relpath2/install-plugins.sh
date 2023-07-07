#!/usr/bin/env bash

#WordPress Batch Plugin Installer WP-CLI
#Author https://guides.wp-bullet.com

#define array of plugin slugs to install
WPPLUGINS=( wordpress-seo ewww-image-optimizer better-wp-security )

#specify path to WordPress installation
WPPATH=/var/www/guides.wp-bullet.com

#loop through array, install and activate the plugin, ${WPPLUGINS[@]}
for WPPLUGIN in "${WPPLUGINS[@]}"; do
#check if plugin is installed, sets exit status to 1 if not found
    wp plugin is-installed $WPPLUGIN --path=$WPPATH --allow-root

#install plugin if not present based on exit code value
    if [ $? -eq 1 ]; then
        wp plugin install $WPPLUGIN --activate --path=$WPPATH --allow-root
    fi
done

#Fix permissions in case you ran as root
sudo chown -R www-data:www-data $WPPATH
sudo find $WPPATH -type f -exec chmod 644 {} +
sudo find $WPPATH -type d -exec chmod 755 {} +
