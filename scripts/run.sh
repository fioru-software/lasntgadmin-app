#! /bin/sh

dir="/usr/local/bin"
$dir/install.sh # install wp 
$dir/groups.sh # create groups
$dir/funding_sources.sh # create funding sources for grant funded payment gateway
$dir/roles.sh # create user roles
$dir/caps.sh # create user roles
$dir/composer_install.sh
$dir/plugins.sh # install plugins
$dir/product_cat.sh #create product categories
$dir/themes.sh # install themes

if [ $# -eq 0 ]; then
    service cron start
    apache2-foreground
fi
