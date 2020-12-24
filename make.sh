#!/bin/bash

cd ./notes-md

# Convert .md files to .html
find . -type f -name '*.md' | while IFS='' read -r file
do
	mkdir -p "../notes-html/${file%/*}"                    # create the containing directory
	pandoc -o "../notes-html/${file%.md}.html" "$file"     # convert *.md to *.html
done

cd ..

# Generate index.html
cat ./templates/header.html > index.html
find notes-html -type f -name '*.html' | while IFS='' read -r file
do
	read -r title < "$file"  # assuming it is the first line
	printf '<a href="%s">%s</a></br>\n' "$file" "$file"
done >> index.html
cat ./templates/footer.html >> index.html
