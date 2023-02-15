#!/bin/bash

# Check if the script was invoked with an argument
if [ -z "$1" ]; then
  echo "Please provide a string argument."
  exit 1
fi

# Replace the "test" parameter with the provided argument
url="https://search.censys.io/search?resource=hosts&sort=RELEVANCE&per_page=25&virtual_hosts=EXCLUDE&q=$1"

# Use curl to retrieve the modified URL and grep the output for the provided string
output=$(curl -s "$url" | grep -Eo '([a-zA-Z0-9]+\.)*'"$1")

# Remove any duplicates from the output
output=$(echo "$output" | tr ' ' '\n' | sort -u | tr '\n' ' ')

# Check if any strings were found
if [ -z "$output" ]; then
  echo "No subdomains found."
else
  echo "Subdomains found:"
  echo "$output"
fi
