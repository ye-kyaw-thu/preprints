#!/bin/bash

# Define the base directory
BASE_DIR="$HOME/exp/nmt/cv-predict/data/mask"

# Function to run masking for a given folder and mask value
run_masking() {
    local FOLDER="$1"
    local MASK_VALUE="$2"
    
    echo "Processing folder: $FOLDER with --mask $MASK_VALUE"
    
    # Iterate through each language folder
    for LANG_DIR in "$FOLDER"/rm-*; do
        if [ -d "$LANG_DIR" ]; then
            echo "  Processing language: $(basename "$LANG_DIR")"
            
            # Process train.sy, dev.sy, and test.sy
            for FILE_TYPE in train dev test; do
                INPUT_FILE="$LANG_DIR/$FILE_TYPE.sy"
                OUTPUT_FILE="$LANG_DIR/$FILE_TYPE.mk"
                
                if [ -f "$INPUT_FILE" ]; then
                    echo "    Masking $INPUT_FILE -> $OUTPUT_FILE"
                    python mask_syllables.py --input "$INPUT_FILE" --output "$OUTPUT_FILE" --mask "$MASK_VALUE" --mask_symbol "_"
                else
                    echo "    File not found: $INPUT_FILE"
                fi
            done
        fi
    done
}

# Run masking for the 3/ folder with --mask 3
run_masking "$BASE_DIR/3" 3

# Run masking for the 5/ folder with --mask 5
run_masking "$BASE_DIR/5" 5

# Run masking for the 3/ folder with --mask 3
run_masking "$BASE_DIR/8" 8

# Run masking for the 5/ folder with --mask 5
run_masking "$BASE_DIR/10" 10

echo "Masking process completed!"


