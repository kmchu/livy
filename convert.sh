#!/bin/bash

InputDir=$1
OutputDir=$2

function Usage() {
    echo "./convert.sh <input dir> <output dir>"
}

function Convert() {
    find $1 -type f -name '*.md' | while IFS='' read -r file
    do
        ShortenedInputDir="${file#$InputDir/}"
        Destination="$2/${ShortenedInputDir%.md}.html"

        mkdir -p "${Destination%/*}"
        pandoc -o "${Destination}" "$file"
    done
}


if [[ $# != 2 ]] || [[ ! -d "$InputDir" ]] || [[ ! -d "$OutputDir" ]]
then
    Usage
else
    Convert $InputDir $OutputDir
fi
