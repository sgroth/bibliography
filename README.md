# Bibliography
German and English BibTeX bibliographies of my publications, continuously updated. Includes TeX-files for German and English lists of publications, including version control information via [`gitfile-info`](https://www.ctan.org/pkg/gitfile-info?lang=de).

## Workflow for LaTeX-files
1. Update German and English bib-files
2. Commit and sync changes
3. Run `pythonw gfi-run.py` in working directory to get and store version number
4. Run `pdflatexmk` to typeset list of publications
5. Upload PDF files to server ([http://stefangroth.com/data/publications.en.pdf](http://stefangroth.com/data/publications.en.pdf) and [http://stefangroth.com/data/publications.de.pdf](http://stefangroth.com/data/publications.de.pdf))

## To-Do
* Create `Makefile` to automatically execute the workflow and clean up the working directory
* Add option to create Markdown versions (currently done via [citeproc-ruby](https://github.com/inukshuk/citeproc-ruby) and [jekyll-scholar](https://github.com/inukshuk/jekyll-scholar) for my [website](https://www.stefangroth.com/publications))
