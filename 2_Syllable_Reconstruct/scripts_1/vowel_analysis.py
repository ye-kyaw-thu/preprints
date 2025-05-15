import sys
import argparse
from collections import defaultdict
import matplotlib.pyplot as plt

def analyze_vowels(input_file, output_file=None):
    # Read the input file with UTF-8 encoding
    with open(input_file, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    # Initialize variables for analysis
    vowel_counts = []
    vowel_frequency = defaultdict(int)

    # Process each line
    for line in lines:
        syllables = line.strip().split()
        for syllable in syllables:
            # Count the number of vowels in the syllable
            vowel_count = len(syllable)
            vowel_counts.append(vowel_count)
            # Update the frequency of each vowel
            for vowel in syllable:
                vowel_frequency[vowel] += 1

    # Calculate min, max, and average
    min_vowels = min(vowel_counts)
    max_vowels = max(vowel_counts)
    avg_vowels = sum(vowel_counts) / len(vowel_counts)

    # Prepare the output
    output = [
        f"Minimum number of vowels in one syllable: {min_vowels}",
        f"Maximum number of vowels in one syllable: {max_vowels}",
        f"Average number of vowels in one syllable: {avg_vowels:.2f}",
        "\nFrequency of each vowel:",
    ]

    # Add vowel frequencies to the output
    for vowel, frequency in sorted(vowel_frequency.items()):
        output.append(f"{vowel}: {frequency}")

    # Join the output into a single string
    output_str = "\n".join(output)

    # Print to screen (stdout)
    print(output_str)

    # Save to file if an output file is specified
    if output_file:
        with open(output_file, 'w', encoding='utf-8') as file:
            file.write(output_str)

    # Generate visualization
    visualize_vowel_frequencies(vowel_frequency)

def visualize_vowel_frequencies(vowel_frequency):
    # Sort vowels by frequency (descending)
    sorted_vowels = sorted(vowel_frequency.items(), key=lambda x: x[1], reverse=True)
    vowels = [v[0] for v in sorted_vowels]
    frequencies = [v[1] for v in sorted_vowels]

    # Create a bar chart
    plt.figure(figsize=(12, 6))
    plt.bar(vowels, frequencies, color='skyblue')
    plt.xlabel('Vowel Characters')
    plt.ylabel('Frequency')
    plt.title('Frequency of Each Vowel')
    plt.xticks(rotation=45, fontsize=10)
    plt.tight_layout()

    # Save the plot as an image
    plt.savefig('vowel_frequency.png', dpi=300)
    print("Visualization saved as 'vowel_frequency.png'.")

    # Show the plot (optional)
    plt.show()

def main():
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Analyze vowel distribution in syllables.")
    parser.add_argument('-i', '--input', required=True, help="Input file containing vowels per syllable.")
    parser.add_argument('-o', '--output', help="Output file to save the results.")
    args = parser.parse_args()

    # Perform the analysis
    analyze_vowels(args.input, args.output)

if __name__ == "__main__":
    main()


