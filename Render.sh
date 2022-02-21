#!/usr/bin/env bash
# We need a build system for this if we keep modifying it.
# For now a shell script will do

# MARKDOWN

# Dependencies:
# You need eisvogel template for markdown for the nice looking pdfs.
# https://github.com/Wandmalfarbe/pandoc-latex-template

# Here is how I rendered the MD files last time...
# Add license (only once).
# for i in */*.md; do cat ./license.txt >> "$i"; done

# Use Pandoc to render PDFs
for i in *.md; do pandoc "$i" -o "${i%.md}".pdf --template eisvogel; done 
for i in */*.md; do pandoc "$i" -o "${i%.md}".pdf --template eisvogel; done 

# Latex Beamer

# Dependencies:
# The presentation slide decks are created with beamer. 
# So you need a build environment with these.

# This version creates both notes and slides from tex files.
texfiles=($(find . -type f -name '*.tex'))
for file in "${texfiles[@]}"; do
  echo $file
  latexmk  -quiet -cd -pdf $file
  mv "${file%.tex}".pdf "${file%.tex}"S.pdf
  # Create Notes Version
  sed -i -e 's/^\\setbeameroption{hide notes}/\\setbeameroption{show notes on second screen=right}/g' $file
  latexmk  -quiet -cd -pdf $file
  mv "${file%.tex}".pdf "${file%.tex}"N.pdf
  sed -i -e 's/^\\setbeameroption{show notes on second screen=right}/\\setbeameroption{hide notes}/g' $file
done

# Delete Latex artifacts
find . -type f -name '*.aux' -print -delete
find . -type f -name '*.fls' -print -delete
find . -type f -name '*_latexmk' -print -delete
find . -type f -name '*.log' -print -delete
find . -type f -name '*.nav' -print -delete
find . -type f -name '*.out' -print -delete
find . -type f -name '*.snm' -print -delete
find . -type f -name '*.toc' -print -delete

#dirs=($(find . -type d))
#for dir in "${dirs[@]}"; do
#  cd "$dir"
#  latexmk -pdf *.tex
#  latexmk -c
#done


