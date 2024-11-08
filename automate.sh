#!/bin/bash

# Check the working directory
WORK_DIR=$(pwd)

# Automate subfinder scan, nmap, and nuclei for li.st of csirt enabled website

if [[ -z $1 ]]; then
    while read -r domain; do
        if [[ -z $domain ]]; then
            break
        fi

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

        cd $WORKDIR
    done
fi