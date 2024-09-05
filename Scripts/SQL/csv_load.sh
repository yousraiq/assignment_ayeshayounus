#!/bin/bash

DB_NAME="posey"
CSV_DIR="csv_files"
DB_USER="postgres"   # PostgreSQL username
DB_PASSWORD="admin"  # Replace with actual PostgreSQL password

# Set PostgreSQL environment variables
export PGUSER=$DB_USER
export PGPASSWORD=$DB_PASSWORD

# Function to create a table based on CSV header
create_table() {
    local csv_file=$1
    local table_name=$2

    # Extract header (first row) from CSV and generate table structure
    header=$(head -n 1 "$csv_file")
    columns=$(echo $header | sed 's/,/ TEXT,/g') # Assuming all columns are TEXT, modify as needed
    columns="$columns TEXT" # Last column without trailing comma

    # Create table SQL command
    create_sql="CREATE TABLE IF NOT EXISTS $table_name ($columns);"

    # Execute table creation
    psql -d $DB_NAME -c "$create_sql"
    echo "Created table $table_name in PostgreSQL if it didn't exist."
}

# Iterate over CSV files and copy them into PostgreSQL
for csv_file in $CSV_DIR/*.csv; do
    table_name=$(basename "$csv_file" .csv)

    # Create table if not exists
    create_table "$csv_file" "$table_name"

    # Load CSV data into PostgreSQL
    psql -d $DB_NAME -c "\COPY $table_name FROM '$csv_file' CSV HEADER;"
    echo "Loaded $csv_file into PostgreSQL table $table_name."
done

# Unset password after the operation for security reasons
unset PGPASSWORD
