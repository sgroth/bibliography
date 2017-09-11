#!/bin/bash
# add and commit to git (bib files)
git add *
git commit -m "updated bib data"
# sync with git
git push origin master
# get vc info (pythonw)
pythonw gfi-run.py
# run latexmk
latexmk -pdf publications.de.tex
# delete aux-files
latexmk -CA publications.de.tex
# move pdf to subdirectory
mv publications.de.pdf pdf/
# add and commit to git (PDF result)
git add pdf/publications.de.pdf
git commit -m "updated PDF version"
# sync with git
git push origin master
