# Awesome WordPress Cli Commands

I often reference this list of useful WordPress CLI commands to enhance or clean up my sites. Please be careful and make backups.

How to install [WordPress CLI](https://wp-cli.org/#installing). Here you can checkout the [commands](https://developer.wordpress.org/cli/commands/).

List:

- [Syncing High-Performance Order Storage](#syncing-high-performance-order-storages)
- [Cleaning Woocommerce trash products](#cleaning-woocommerce-trash-products)
- [Cleaning unattached jpegs from the WordPress library](#cleaning-unattached-jpegs-from-the-wordpress-library)
- [Creating Dummy content](#creating-dummy-content)
- [Cleaning your website](#cleaning-your-website)
- [Checking the config file](#checking-the-config-file)
- [Checking the database size](#checking-the-database-size)
- [Running core update](#running-core-update)
- [Plugins manipulation](#plugins-manipulation)
- [Reseting User Password](#reseting-user-password)
- [Database Manipulations](#database-manipulations)

### Syncing High-Performance Order Storage
```bash
wp wc cot sync
```

### Cleaning Woocommerce trash products
```bash
wp post delete $(wp post list --post_type=product --post_status=trash --format=ids) --force
```

### Cleaning unattached jpegs from the WordPress library
```bash
for id in $(wp db query "SELECT ID FROM wp_posts where post_type='attachment' AND post_parent=0 AND post_mime_type='image/jpeg'" --silent --skip-column-names)
do
    wp post delete --force $id
done
```
### Creating Dummy content
```bash
wp post generate --count=10
```

### Cleaning your website
```bash
wp site empty
```

### Checking the config file
```bash
wp config get
```

### Checking the database size
```bash
wp db size --tables
```

### Running core update
```bash
wp core update
```

### Plugins manipulation

#### List
```bash
wp plugin list
```
#### Install
```bash
wp plugin install
```

#### Update
```bash
wp plugin update plugin-name
```

#### Disable
```bash
wp plugin deactivate plugin-name
```

#### Delete
```bash
wp plugin delete plugin-name
```

### Reseting User Password
```bash
wp user update user@example.com --user_pass=new-password
```

### Database Manipulations

#### Optimization
```bash
wp db optimize
```
#### Repair
```bash
wp db repair
```

#### Backup
```bash
wp db export name.sql
```
