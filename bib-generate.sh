#!/bin/bash
# add and commit to git (bib files)
git add *
git commit -m "updated bib data"
# sync with git
git push origin master
# get vc info (pythonw)
pythonw gfi-run.py
# delete contents of pdf
rm -rf pdf
# mkdir
mkdir pdf
chmod 777 pdf
# run latexmk
latexmk -pdf publications.de.tex
# delete aux-files
# latexmk -CA publications.de.tex
# move pdf to subdirectory
mv publications.de.pdf pdf/
# add and commit to git (PDF result)
git add *
git commit -m "updated PDF version"
# sync with git
git push origin master
