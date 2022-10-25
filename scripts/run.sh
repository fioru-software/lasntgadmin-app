#! /bin/sh

dir="/usr/local/bin"
$dir/install.sh # install wp 
$dir/groups.sh # create groups
$dir/product_cat.sh #create product categories
$dir/roles.sh # create user roles
$dir/plugins.sh # install plugins
$dir/themes.sh # install themes
$dir/composer.sh

if [ $# -eq 0 ]; then
    apache2-foreground
fi
