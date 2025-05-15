import argparse
import random

def mask_syllables(sentence, mask_symbol, num_masks):
    """
    Randomly masks syllables in a sentence, ensuring no two masked syllables are consecutive.
    
    Args:
        sentence (list): List of syllables in the sentence.
        mask_symbol (str): Symbol to use for masking (e.g., '_' or '[MASK]').
        num_masks (int): Number of syllables to mask.
    
    Returns:
        list: List of syllables with masked tokens.
    """
    if num_masks > len(sentence):
        # If the sentence is too short, return it as-is (no masking)
        return sentence, 0
    
    # Generate a list of all valid indices (excluding consecutive positions)
    valid_indices = [i for i in range(len(sentence))]
    
    # Randomly shuffle the valid indices
    random.shuffle(valid_indices)
    
    # Select the first `num_masks` indices that are not consecutive
    masked_indices = []
    for index in valid_indices:
        if len(masked_indices) >= num_masks:
            break
        # Ensure the previous and next indices are not already masked
        if (index - 1) not in masked_indices and (index + 1) not in masked_indices:
            masked_indices.append(index)
    
    # Mask the selected syllables
    for index in masked_indices:
        sentence[index] = mask_symbol
    
    return sentence, len(masked_indices)  # Return the masked sentence and the number of masks applied

def main():
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="Randomly mask syllables in a sentence.")
    parser.add_argument("--input", type=str, required=True, help="Path to the input file (UTF-8 encoded).")
    parser.add_argument("--output", type=str, required=True, help="Path to the output file (UTF-8 encoded).")
    parser.add_argument("--mask", type=int, required=True, help="Number of syllables to mask.")
    parser.add_argument("--mask_symbol", type=str, default="_", help="Symbol to use for masking (default: _).")
    args = parser.parse_args()
    
    # Initialize statistics
    total_sentences = 0
    skipped_sentences = 0
    masked_sentences = 0
    total_masked_syllables = 0
    total_syllables = 0
    
    # Process the input file line by line
    with open(args.input, "r", encoding="utf-8") as infile, open(args.output, "w", encoding="utf-8") as outfile:
        for line in infile:
            total_sentences += 1
            sentence = line.strip().split()
            total_syllables += len(sentence)
            
            # Check if the sentence is too short
            if len(sentence) < args.mask:
                # Write the sentence as-is (no masking)
                outfile.write(" ".join(sentence) + "\n")
                skipped_sentences += 1
            else:
                # Mask syllables
                masked_sentence, num_masks = mask_syllables(sentence, args.mask_symbol, args.mask)
                outfile.write(" ".join(masked_sentence) + "\n")
                masked_sentences += 1
                total_masked_syllables += num_masks
    
    # Calculate additional statistics
    avg_syllables_per_sentence = total_syllables / total_sentences if total_sentences > 0 else 0
    skip_percentage = (skipped_sentences / total_sentences) * 100 if total_sentences > 0 else 0
    
    # Print statistics
    print("\n===== Masking Statistics =====")
    print(f"Total sentences processed: {total_sentences}")
    print(f"Sentences successfully masked: {masked_sentences}")
    print(f"Sentences skipped (too short): {skipped_sentences} ({skip_percentage:.2f}%)")
    print(f"Total syllables masked: {total_masked_syllables}")
    print(f"Average syllables per sentence: {avg_syllables_per_sentence:.2f}")

if __name__ == "__main__":
    main()

