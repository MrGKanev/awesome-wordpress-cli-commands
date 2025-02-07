#!/bin/bash

echo "🚀 Starting WordPress Cleanup via WP-CLI..."

# Ensure WP-CLI is available
if ! command -v wp &> /dev/null; then
    echo "❌ WP-CLI is not installed. Exiting..."
    exit 1
fi

# Step 1: Scan for Malware & Suspicious Files
echo "🔍 Scanning for modified files in the last 7 days..."
find . -type f -mtime -7 -exec ls -lh {} \;

echo "🔍 Searching for potential malicious code..."
grep -r --include=*.php "base64_decode\|eval\|gzinflate\|str_rot13" wp-content/

# Step 2: Reset & Reinstall WordPress Core
echo "🛠️ Reinstalling WordPress core..."
wp core download --force
wp core verify-checksums

# Step 3: Update Everything
echo "🔄 Updating plugins, themes, and WordPress..."
wp plugin update --all
wp theme update --all
wp core update

# Step 4: Remove Inactive Plugins & Themes
echo "🗑️ Deleting inactive plugins..."
wp plugin delete $(wp plugin list --status=inactive --field=name)

echo "🗑️ Deleting inactive themes..."
wp theme delete $(wp theme list --status=inactive --field=name)

# Step 5: Reset .htaccess & Flush Caches
echo "🔧 Flushing rewrite rules and resetting .htaccess..."
wp rewrite flush

echo "🧹 Flushing cache..."
wp cache flush

# Step 6: Final Log Check
echo "📜 Monitoring logs for potential threats..."
tail -f wp-content/debug.log

echo "✅ WordPress Cleanup Completed Successfully!"