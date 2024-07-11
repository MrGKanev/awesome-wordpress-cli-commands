# Awesome WordPress Cli Commands

I often reference this list of useful WordPress CLI commands to enhance or clean up my sites. Please be careful and make backups.

How to install [WordPress CLI](https://wp-cli.org/#installing). Here you can checkout the [commands](https://developer.wordpress.org/cli/commands/).

List:

- [Syncing High-Performance Order Storage](#syncing-high-performance-order-storages)
- [Recovering WordPress after a fatal error from plugin update](#recovering-wordpress-after-a-fatal-error-from-plugin-update)
- [Cleaning Woocommerce trash products](#cleaning-woocommerce-trash-products)
- [Cleaning unattached jpegs from the WordPress library](#cleaning-unattached-jpegs-from-the-wordpress-library)
- [Creating Dummy content](#creating-dummy-content)
- [Deleting spam comments](#deleting-spam-comments)
- [Truly stopping comments](#truly-disabling/stopping-comments)
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

### Recovering WordPress after a fatal error from plugin update

```bash
wp plugin deactivate plugin-says-no --skip-plugins
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

### Cleaning unattached jpegs from the WordPress library in batches. You can change the batch size by changing the value of the `batch_size` variable. 

```bash
# !/bin/bash

# Fetch all IDs in one command and store them in an array

ids=($(wp db query "SELECT ID FROM wp90_posts WHERE post_type='attachment' AND post_parent=0 AND post_mime_type='image/jpeg'" --silent --skip-column-names))

# Function to delete posts in batches

delete_in_batches() {
    local batch=("$@")
    if ! wp post delete --force "${batch[@]}"; then
        echo "Error: Failed to delete one or more posts in this batch."
        exit 1
    fi
}

# Batch size

batch_size=500

# Total number of IDs

total_ids=${#ids[@]}

# Process IDs in batches of 500

for ((i=0; i<total_ids; i+=batch_size)); do
    batch=("${ids[@]:i:batch_size}")
    echo "Deleting batch starting with ID ${batch[0]}"
    delete_in_batches "T${batch[@]}"
done

echo "Deletion process completed."
```

Using scripts/batch-delete-unattached-jpegs.sh it is nearly 1.5x faster than the previous command. Don't forget to make the script executable by running `chmod +x scripts/batch-delete-unattached-jpegs.sh`.

### Creating Dummy content

```bash
wp post generate --count=10
```

### Deleting spam comments

```bash
wp comment list --status=spam --format=ids | xargs wp comment delete --force
```

### Truly disabling/stopping comments

```bash
wp option update default_comment_status closed
wp option update default_ping_status closed
wp db query "UPDATE wp_posts SET comment_status='closed' WHERE post_status='publish';"
wp db query "UPDATE wp_posts SET ping_status='closed' WHERE post_status='publish';"
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
