#!/bin/bash

rm *.md.html
rm *.pdf

find . -name "*.md" -exec markdown2pdf {} \;
find . -name "*.md" -exec markdownhere {} \;