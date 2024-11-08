#!/bin/bash

# Check the working directory

# Automate subfinder scan, nmap, and nuclei for list of csirt enabled website
while read -r domain; do
    echo "Automating check for: $line"

    # Check if directory exists, if not, create the new one
    if ! [[ -d ./$domain ]]; then
        mkdir $domain
    fi

    # Working in the directory
    cd ./$domain


done