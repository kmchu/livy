#!/bin/bash

InputDir=$1
OutputDir=$2
ExecDir=`dirname -- "$( readlink -f -- "$0"; )";`

function Usage() {
    echo "livy <input dir> <output dir>"
}

# Convert <InputDir> <OutputDir> <ExecDir>
function Convert() {
    find $1 -type f -name '*.md' | while IFS='' read -r file
    do
        ShortenedInputDir="${file#$1/}"
        Destination="$2/${ShortenedInputDir%.md}.html"

        mkdir -p "${Destination%/*}"
        pandoc \
            --katex \
            --from markdown+tex_math_single_backslash \
            --filter pandoc-sidenote \
            --template="$3"/templates/template.html5 \
            --css=css/styles.css \
            --css=css/skylighting-solarized-theme.css \
            --to html5+smart \
            -o "${Destination}" \
            "$file"
    done
}

# CopyEssentials <OutputDir> <ExecDir>
function CopyEssentials() {
    echo $2
    cp -R "$2/css" "$1"
}


if [[ $# != 2 ]] || [[ ! -d "$InputDir" ]] || [[ ! -d "$OutputDir" ]]
then
    Usage
else
    Convert $InputDir $OutputDir $ExecDir
    CopyEssentials $OutputDir $ExecDir
fi
