# Bibliography
German and English BibTeX bibliographies of my publications, continuously updated. Includes TeX-files for German and English lists of publications, including version control information via [`gitfile-info`](https://www.ctan.org/pkg/gitfile-info?lang=de).

## Workflow for LaTeX-files
1. Update German and English bib-files
2. Commit and sync changes
3. Run `pythonw gfi-run.py` in working directory to get and store version number
4. Run `pdflatexmk` to typeset list of publications
