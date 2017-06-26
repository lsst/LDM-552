export TEXMFHOME = lsst-texmf/texmf

LDM-552.pdf: *.tex
	latexmk -bibtex -pdf -f LDM-552.tex
