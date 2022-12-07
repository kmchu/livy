#!/bin/bash

InputDir=$1
OutputDir=$2

function Usage() {
    echo "./gen_index.sh <input dir> <output dir>"
}

function GenerateIndex() {
    cat ./templates/header.html > index.html
    find $1 -type f -name '*.html' | while IFS='' read -r file
    do
        read -r title < "$file"  # assuming it is the first line
        printf '<a href="%s">%s</a></br>\n' "$file" "$file"
    done >> index.html
    cat ./templates/footer.html >> index.html
}

function MoveFile() {
    mv index.html $1/
}

if [[ $# != 2 ]] || [[ ! -d "$InputDir" ]] || [[ ! -d "$OutputDir" ]]
then
    Usage
else
    GenerateIndex $InputDir
    MoveFile $OutputDir
fi

