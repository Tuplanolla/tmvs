build: report.pdf data-flow.png

%.pdf: %.tex data-flow.tex
	pdflatex $<

%.tex: %.dot
	dot2tex --codeonly --format tikz --texmode verbatim -o $@ $<

%.png: %.dot
	dot -Efontname=sans -Gfontname=sans -Nfontname=sans $< > $@
