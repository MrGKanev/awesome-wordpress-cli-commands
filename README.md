# Awesome WordPress Cli Commands

I often reference this list of useful WordPress CLI commands to enhance or clean up my sites. Please be careful and make backups.

How to install [WordPress CLI](https://wp-cli.org/).

List:

- [Syncing High-Performance Order Storage](#syncing-high-performance-order-storages)

### Syncing High-Performance Order Storage
```bash
wp wc cot sync
```

### Cleaning Woocommerce trash products
```bash
wp post delete $(wp post list --post_type=product --post_status=trash --format=ids) --force
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
