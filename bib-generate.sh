#!/bin/bash
# delete pre-generated pdf if exists
rm publications.de.pdf
# add and commit to git (bib files)
git add *
git commit -m "updated bib data"
# sync with git
git push origin master
# get vc info (pythonw)
python3 gfi-run.py
# delete contents of pdf and markdown
rm -rf markdown
rm -rf pdf

# mkdir
mkdir pdf
chmod 777 pdf
mkdir markdown
chmod 777 markdown

# create markdown version
ruby publications.rb
ruby publications.en.rb

#cp publications.de.md publications.en.md
# sed -i '' -e 's/Zur[[:space:]]Publikation[[:space:]]eingereicht/Submitted for publication/g; s/In[[:space:]]Vorbereitung/In preparation/g; s/Rezension[[:space:]]von/Review of/g; s/herausgegeben[[:space:]]von/edited by/g; s/} von/} by/g; s/Im[[:space:]]Druck/In print/g; s/Sondernummer/special issue/g; s/Zur[[:space:]]Publikation[[:space:]]angenommen/Accepted for publication/g' publications.en.md

mv publications.de.md markdown/
mv publications.en.md markdown/

# create en.bib and replace strings
# cp sgroth-bibliography.bib sgroth-bibliography.en.bib
# sed -i '' -e 's/Zur[[:space:]]Publikation[[:space:]]eingereicht/Submitted for publication/g; s/In[[:space:]]Vorbereitung/In preparation/g; s/Rezension[[:space:]]von/Review of/g; s/herausgegeben[[:space:]]von/edited by/g; s/} von/} by/g; s/Im[[:space:]]Druck/In print/g; s/Sondernummer/special issue/g; s/Zur[[:space:]]Publikation[[:space:]]angenommen/Accepted for publication/g' sgroth-bibliography.en.bib

# run latexmk
latexmk -pdf publications.de.tex
latexmk -pdf publications.en.tex
# delete aux-files
# latexmk -CA publications.de.tex
# delete en.bib
# rm sgroth-bibliography.en.bib
# delete markdown files
rm publications.de.md
rm publications.en.md
# move pdf to subdirectory
mv publications.de.pdf pdf/
mv publications.en.pdf pdf/
# add and commit to git (PDF result)
git add *
git commit -m "updated PDF and markdown version"
# sync with git
git push origin master
