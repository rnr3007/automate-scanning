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

    echo "==================="
    echo "Starting subfinder"
    echo "==================="
    subfinder -d $domain -o subfinder.txt

    echo "==================="
    echo "Starting nuclei"
    echo "==================="
    nuclei -l subfinder.txt -t ~/nuclei-templates/ -o nuclei-full.txt

    echo "==================="
    echo "Starting httpx"
    echo "==================="
    httpx -l subfinder.txt -silent -o httpx.txt -fc 200
done