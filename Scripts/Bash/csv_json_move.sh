#!/bin/bash

SOURCE_DIR="./source"
DEST_DIR="./json_and_CSV"

# Create destination folder if it doesn't exist
mkdir -p $DEST_DIR

# Check if the source directory exists before proceeding
if [ -d "$SOURCE_DIR" ]; then
    # Move all CSV and JSON files to the destination folder
    find $SOURCE_DIR -type f \( -name "*.csv" -o -name "*.json" \) -exec mv {} $DEST_DIR \;

    # Check if files were moved
    if [ "$(ls -A $DEST_DIR)" ]; then
        echo "Files moved to json_and_CSV folder."
    else
        echo "No files moved."
    fi
else
    echo "Source directory does not exist."
fi

