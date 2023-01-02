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
            --embed-resources \
            --standalone \
            --template="$3"/templates/template.html5 \
            --css=css/styles.css \
            --css=css/skylighting-solarized-theme.css \
            --to html5+smart \
            -o "${Destination}" \
            "$file"

        # Copy .md file timestamp to generated .html
        touch -r "$file" "$Destination"
    done
}

# CopyEssentials <OutputDir> <ExecDir>
function CopyEssentials() {
    cp -R "$2/css" "$1"
}


# GenerateIndex <HTMLdir> <ExecDir>
function GenerateIndex() {
    cat $2/templates/header.html > $1/index.html
    find $1 -type f -name '*.html' | while IFS='' read -r file
    do
        printf '<a href="%s">%s</a></br>\n' "$file" "$file"
    done >> $1/index.html
    cat $2/templates/footer.html >> $1/index.html
}


if [[ $# != 2 ]] || [[ ! -d "$InputDir" ]] || [[ ! -d "$OutputDir" ]]
then
    Usage
else
    CopyEssentials $OutputDir $ExecDir
    Convert $InputDir $OutputDir $ExecDir
    GenerateIndex $OutputDir $ExecDir
fi
