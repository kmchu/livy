#!/bin/bash

InputDir=$1

function Usage() {
    echo "./gen_index.sh <input dir>"
}

function GenerateIndex() {
    cat ./templates/header.html > index.html
    cd $1
    find . -type f -name '*.html' | while IFS='' read -r file
    do
        read -r title < "$file"  # assuming it is the first line
        printf '<a href="%s">%s</a></br>\n' "$file" "$file"
    done >> index.html
    cd - > /dev/null
    cat ./templates/footer.html >> index.html
}

function Move() {
    mv 
}

if [[ $# != 1 ]] || [[ ! -d "$InputDir" ]]
then
    Usage
else
    GenerateIndex $InputDir
fi

