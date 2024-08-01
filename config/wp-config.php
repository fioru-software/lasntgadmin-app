<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

define( 'AUTOMATIC_UPDATER_DISABLED', true );
define( 'WP_AUTO_UPDATE_CORE', false );
define( 'DISABLE_WP_CRON', true );

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'secret' );

/** Database hostname */
define( 'DB_HOST', 'db' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

// adjust Redis host and port if necessary 
define( 'WP_REDIS_HOST', 'production-lasntgadmin-redis-service.default.svc.cluster.local' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_DISABLE_BANNERS', true );

// change the prefix and database for each site to avoid cache data collisions
define( 'WP_REDIS_PREFIX', 'lasntgadmin' );
define( 'WP_REDIS_DATABASE', 0 ); // 0-15

// reasonable connection and read+write timeouts
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_IGBINARY	', true );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'd/tD,gO5K5M7|7.#uv*15vgKAK%h1`^gr2b!VE5Ud;A>eeI:yV|_4q5i*%MO3Koi' );
define( 'SECURE_AUTH_KEY',   'P(<:?46dAl6lGeqVSyEChy&V$M,8z#z88W$)~hmqa;GdJA`4wRc>/+%y$y}>M@e2' );
define( 'LOGGED_IN_KEY',     'PXg-1,Js0ncOKha0nA?)=bqEWP]D3q:jWrIB.CIqrlVOnM+x,5gWA:a`O[fkb_u>' );
define( 'NONCE_KEY',         'R7ugbwSk=sS!XWv`@REEPhFT<!J:Aikk>)B+~P|D?bHUC;Pg2s?9Uq2z` 2U4o*$' );
define( 'AUTH_SALT',         ';pT{DW?Hwm`/WkJz2j]#y2#d!A;RzHbT(d> /w^&RRl&j,2Jf[!$x5 id@qidha-' );
define( 'SECURE_AUTH_SALT',  's&~9lj{zp}!Xb?fbj/F714~vfg4xX{6x!Z_2e$_E DD.kX#rc}mo.Y#}`>HWUv}[' );
define( 'LOGGED_IN_SALT',    'R fYxPO;[DC<ZjBpzsI`K:!)#mr_[68{f3YY)#ud- I BGxMAYFkinwG9`K*^+S|' );
define( 'NONCE_SALT',        '0>)EO/5V(ko{((a:h}f<p ?FZBDIw8]k#/;EnVZ9-t7yLaKP5.cMhWJZfo6t+3r`' );
define( 'WP_CACHE_KEY_SALT', '^$2NPGKG<s8@vAKB~JmEZn6S,9dK!6:vILQ3V|ft+EJ:{a.iGMQ$ersvbCHSOy:?' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */

/* Add any custom values between this line and the "stop editing" line. */

define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
