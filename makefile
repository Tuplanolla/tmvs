build: CSVParser.java IdParser.java data-flow.png report.pdf

clean:
	$(RM) *.aux *.log *.out
	$(RM) *.class *.java *.tokens
	# $(RM) *.tmp

%.pdf: %.tex data-flow.tex
	pdflatex $<

%.tex: %.dot
	dot2tex --codeonly --format tikz --texmode verbatim -o $@ $<

%Parser.java: %.g4
	antlr4 $<

%.png: %.dot
	dot -Efontname=sans -Gfontname=sans -Nfontname=sans $< > $@
