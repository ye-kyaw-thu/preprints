#!/bin/bash

# Define the list of language codes
languages=("bg" "hi" "kh" "lo" "my" "th")

# Loop through each language
for lang in "${languages[@]}"; do
    # Define the base directory for the current language
    base_dir="./rm-${lang}"

    # Process train.sy
    input_file="${base_dir}/train.sy"
    output_file="${base_dir}/train.rm"
    if [[ -f "$input_file" ]]; then
        echo "Processing $input_file..."
        python3.10 rm_random_chars.py -i "$input_file" -o "$output_file" -c 1
        echo "Output saved to $output_file"
        echo ""
    else
        echo "Input file $input_file does not exist. Skipping..."
        echo ""
    fi

    # Process dev.sy
    input_file="${base_dir}/dev.sy"
    output_file="${base_dir}/dev.rm"
    if [[ -f "$input_file" ]]; then
        echo "Processing $input_file..."
        python3.10 rm_random_chars.py -i "$input_file" -o "$output_file" -c 1
        echo "Output saved to $output_file"
        echo ""
    else
        echo "Input file $input_file does not exist. Skipping..."
        echo ""
    fi

    # Process test.sy
    input_file="${base_dir}/test.sy"
    output_file="${base_dir}/test.rm"
    if [[ -f "$input_file" ]]; then
        echo "Processing $input_file..."
        python3.10 rm_random_chars.py -i "$input_file" -o "$output_file" -c 1
        echo "Output saved to $output_file"
        echo ""
    else
        echo "Input file $input_file does not exist. Skipping..."
        echo ""
    fi
done

echo "All processing complete!"
