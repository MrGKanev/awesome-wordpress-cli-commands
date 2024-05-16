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
    delete_in_batches "${batch[@]}"
done

echo "Deletion process completed."