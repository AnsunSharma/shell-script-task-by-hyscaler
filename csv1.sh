#!/bin/bash

# Function to read CSV file and populate the new CSV file
read_csv_and_write_new() {
    local input_file="$1"
    local output_file="$2"

    # Write header to the new CSV file
    echo "URL,overview,campus,courses,scholarships,admission,placements,results" > "$output_file"

    # Read input CSV file
    while IFS=, read -r url description _ ; do
        # Initialize variables for each column
        overview=""
        campus=""
        courses=""
        scholarships=""
        admission=""
        placements=""
        results=""

        # Check URL for keywords and populate corresponding columns
        if [[ "$url" == *"overview"* ]]; then
            overview="$description"
        fi
        if [[ "$url" == *"campus"* ]]; then
            campus="$description"
        fi
        if [[ "$url" == *"courses"* ]]; then
            courses="$description"
        fi
        if [[ "$url" == *"scholarships"* ]]; then
            scholarships="$description"
        fi
        if [[ "$url" == *"admission"* ]]; then
            admission="$description"
        fi
        if [[ "$url" == *"placements"* ]]; then
            placements="$description"
        fi
        if [[ "$url" == *"results"* ]]; then
            results="$description"
        fi

        # Write row to the new CSV file
        echo "$url,$overview,$campus,$courses,$scholarships,$admission,$placements,$results" >> "$output_file"
    done < "$input_file"
}

# Main script
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_csv_file> <output_csv_file>"
    exit 1
fi

input_csv_file="$1"
output_csv_file="$2"

if [ ! -f "$input_csv_file" ]; then
    echo "File not found: $input_csv_file"
    exit 1
fi

# Call function to read CSV and write new CSV file
read_csv_and_write_new "$input_csv_file" "$output_csv_file"

echo "New CSV file created: $output_csv_file"
