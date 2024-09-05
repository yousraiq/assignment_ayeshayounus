# Set environment variables
URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
RAW_DIR="./raw"
TRANSFORMED_DIR="./Transformed"
GOLD_DIR="./Gold"

# Extract: Download CSV file and save to raw folder
mkdir -p $RAW_DIR
curl -o $RAW_DIR/data.csv $URL
if [ -f "$RAW_DIR/data.csv" ]; then
    echo "File downloaded and saved to raw folder."
else
    echo "File download failed."
    exit 1
fi

# Transform: Rename Variable_code to variable_code and select columns
mkdir -p $TRANSFORMED_DIR
awk -F, 'BEGIN {OFS=","} {gsub("Variable_code", "variable_code", $0)} {print $1, $3, $5, $6}' $RAW_DIR/data.csv > $TRANSFORMED_DIR/2023_year_finance.csv
if [ -f "$TRANSFORMED_DIR/2023_year_finance.csv" ]; then
    echo "Transformation complete, file saved in Transformed folder."
else
    echo "Transformation failed."
    exit 1
fi

# Load: Move transformed file to Gold folder
mkdir -p $GOLD_DIR
mv $TRANSFORMED_DIR/2023_year_finance.csv $GOLD_DIR/
if [ -f "$GOLD_DIR/2023_year_finance.csv" ]; then
    echo "File successfully moved to Gold folder."
else
    echo "File move failed."
    exit 1
fi
