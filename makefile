v=1.0.0

build: CSVParser.class NameParser.class \
	data-flow.png report.pdf tmvs-$(v).tar.gz

clean:
	$(RM) *.aux *.log *.out
	$(RM) *.class *.java *.tokens
	$(RM) *.tmp

deep-clean: clean
	$(RM) *.pdf
	$(RM) *.png
	$(RM) *.tar.gz

install: tmvs-$(v).tar.gz
	octave-cli --norc --quiet --eval 'pkg install $<'

uninstall:
	octave-cli --norc --quiet --eval 'pkg uninstall tmvs'

tmvs-$(v).tar.gz: tmvs.tar.gz
	octave-cli --norc --quiet --eval 'pkg build . tmvs.tar.gz'

tmvs.tar.gz: pkg
	tar acf tmvs.tar.gz pkg

%.class: %.java
	javac $<

%Parser.java: %.g4
	antlr4 $<

%.pdf: %.tex data-flow.tex
	pdflatex $<

%.tex: %.dot
	dot2tex --codeonly --format tikz --texmode verbatim -o $@ $<

%.png: %.dot
	dot -Efontname=sans -Gfontname=sans -Nfontname=sans $< > $@
