import sys
import argparse
import random

def remove_random_chars(word, num_chars):
    """
    Remove `num_chars` random characters from the given word.
    If the word length is less than or equal to `num_chars`, return the word as is.
    """
    if len(word) <= num_chars:
        return word
    # Convert the word to a list of characters for easy manipulation
    chars = list(word)
    # Randomly select `num_chars` indices to remove
    indices_to_remove = random.sample(range(len(chars)), num_chars)
    # Sort indices in descending order to avoid index shifting issues
    indices_to_remove.sort(reverse=True)
    # Remove the characters at the selected indices
    for index in indices_to_remove:
        del chars[index]
    # Convert the list of characters back to a string
    return ''.join(chars)

def process_line(line, num_chars):
    """
    Process each word in the line by removing `num_chars` random characters.
    """
    words = line.strip().split()
    processed_words = [remove_random_chars(word, num_chars) for word in words]
    return ' '.join(processed_words)

def main():
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Remove random characters from words in a file.")
    parser.add_argument('-i', '--input', required=True, help="Input file containing the text.")
    parser.add_argument('-o', '--output', help="Output file to save the processed text.")
    parser.add_argument('-c', '--character', type=int, choices=[1, 2], required=True, help="Number of random characters to remove (1 or 2).")
    args = parser.parse_args()

    # Read the input file with UTF-8 encoding
    with open(args.input, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    # Process each line individually
    processed_lines = []
    for line in lines:
        # Preserve the trailing newline character
        if line.endswith('\n'):
            processed_line = process_line(line, args.character) + '\n'
        else:
            processed_line = process_line(line, args.character)
        processed_lines.append(processed_line)

    # Join the processed lines into a single string
    processed_text = ''.join(processed_lines)

    # Print to screen (stdout)
    print(processed_text, end='')

    # Save to file if an output file is specified
    if args.output:
        with open(args.output, 'w', encoding='utf-8') as file:
            file.write(processed_text)

if __name__ == "__main__":
    main()

