#!/bin/bash

# Define the list of language codes
languages=("bg" "hi" "kh" "lo" "my" "th")

# Loop through each language
for lang in "${languages[@]}"; do
    # Define input and output file paths
    input_file="./data/vo/vo-${lang}/all/${lang}.vo"
    output_file="./${lang}-vo.chk"

    # Check if the input file exists
    if [[ -f "$input_file" ]]; then
        echo "Processing $input_file..."
        # Run the Python script
        python3.10 ./script/vowel_analysis.py --input "$input_file" --output "$output_file"
        echo "Output saved to $output_file"
        echo ""
    else
        echo "Input file $input_file does not exist. Skipping..."
        echo ""
    fi
done

echo "All processing complete!"
