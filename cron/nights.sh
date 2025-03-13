
# groups: wc_batch_processes
export COMPOSER_AUTOLOAD_FILEPATH=/var/www/html/vendor/autoload.php

# process all jobs except subscriptions during week nights
/usr/local/bin/php /usr/local/bin/wp action-scheduler run --batches=1 --batch-size=1 --exclude-groups=lasntgadmin-subscriptions --path=/var/www/html
