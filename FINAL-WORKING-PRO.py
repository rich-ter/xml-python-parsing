import re
import time
import sys
import threading

def extract_years(xml_file_path):
    year_count = {}

    with open(xml_file_path, 'r', encoding='ISO-8859-1') as file:
        for line in file:
            match = re.search(r'<year>(\d+)</year>', line)
            if match:
                year = match.group(1)
                year_count[year] = year_count.get(year, 0) + 1

    return year_count

def print_publication_table(data, sort_by):
    print("Year\tPublications")
    print("------------------")

    if sort_by == 'year':
        sorted_data = sorted(data.items())
    elif sort_by == 'publications':
        sorted_data = sorted(data.items(), key=lambda x: x[1], reverse=True)
    else:
        raise ValueError("Invalid sorting option. Use 'year' or 'publications'.")

    for year, count in sorted_data:
        print(f"{year}\t{count}")

def print_loading():
    chars = "/—\|"
    i = 0
    while True:
        sys.stdout.write('\r' + f'Loading... {chars[i]}')
        sys.stdout.flush()
        time.sleep(0.1)
        i = (i + 1) % len(chars)

def stop_loading():
    sys.stdout.write('\r' + ' ' * 15 + '\r')
    sys.stdout.flush()

# Replace './data.xml' with the actual path to your XML file
xml_file_path = './big-data.xml'

# Prompt user for sorting option
sorting_option = input("Enter sorting option ('year' or 'publications'): ").lower()

# Record start time
start_time = time.time()

# Print a loading animation while processing
loading_thread = threading.Thread(target=print_loading)
loading_thread.start()

# Extract years from the XML file
years_count = extract_years(xml_file_path)

# Stop the loading animation
stop_loading()

# Record end time
end_time = time.time()

# Print the table
print_publication_table(years_count, sorting_option)

# Calculate and print the time taken
time_taken = end_time - start_time
print(f"Time taken to run the program: {time_taken:.4f} seconds")
