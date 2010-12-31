#!/bin/bash

pushd workbook

echo Cleaning up old PDFs
rm pdfs/*.pdf
echo Cleaning up old HTMLs
rm htmls/*.html

pushd markdown
echo Markdown to PDF conversion...
find . -name "*.md" -exec markdown2pdf {} \;
echo Markdown to HTML conversion...
find . -name "*.md" -exec markdown-here.sh {} \;

echo Relocating PDFs to output directory...
mv *.pdf ../pdfs/
echo Relocating HTMLs to output directory...
mv *.html ../htmls/
popd

popd