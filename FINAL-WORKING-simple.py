import re, time

# MAKE SURE THE XML FILE IS UNZIPPED AND IN THE SAME DIRECTORY AS THIS SCRIPT OTHERWISE THE PROGRAM WONT WORK.

# defining the local file path in a variable to limit repetition. 
xml_file_path = './big-data.xml'

def extract_years(xml_file_path):

    #we create a dictionary to store the year count because if we used something else it wouldn't iterate 
    year_count = {}

    # Since the file is extremely large and the pc crashes when the xml file is opened to read it, 
    # we will write a simple loop to print the first 20 lines of the xml results so we can effectively iterate in the tags we are interested in.
    with open(xml_file_path, 'r') as file:
        for x in range(20):
            print('The ' + str(x + 1) +' line of the xml are: ' + file.readline().strip())

    #we loop the lines one by one to find the year tag. We assume that each book has one year tag. If there are more, then this code doesn't handle bad data. 
        for line in file:
    # From the previous printing function we saw that the tag we are interested in has the <year> </year> format. So we will 
    # we use a regular expression to search for that and store it in the year_count dictionary. 

    ############################################################################################################################################
            match = re.search(r'<year>(\d+)</year>', line)
            #IF TRUE
            if match:
                year = match.group(1)
                year_count[year] = year_count.get(year, 0) + 1

    return year_count

def print_publication_table(year_count):
    print("Year\tPublications")
    print("---------------------")
    for year, count in sorted(year_count.items()):
        print(f"{year}\t{count}")


# Record start time
start_time = time.time()

# Extract years from the XML file
# years_count = extract_years(xml_file_path)

# Record end time
end_time = time.time()

# Print the table
# print_publication_table(years_count)

# Calculate and print the time taken
time_taken = end_time - start_time
print(f"Telikos xronos: {time_taken:.4f} seconds")
