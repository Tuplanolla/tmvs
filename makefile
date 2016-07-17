version=1.0.0

build: verify package document report

report: data-flow.png report.pdf

document: manual/index.html

package: tmvs-$(version).tar.gz

verify: CSVParser.class NameParser.class

clean:
	$(RM) *.tmp
	$(RM) *.class CSV*.java Name*.java *.tokens
	$(RM) *.aux *.log *.out

deep-clean: clean
	$(RM) *.tar.gz
	$(RM) data-flow.png
	$(RM) *.pdf
	$(RM) -r manual

install: tmvs-$(version).tar.gz
	octave-cli --norc --quiet --eval 'pkg install $<'

uninstall:
	octave-cli --norc --quiet --eval 'pkg uninstall tmvs'

tmvs-$(version).tar.gz: tmvs.tar.gz
	octave-cli --norc --quiet --eval 'pkg build . tmvs.tar.gz'

tmvs.tar.gz: pkg
	tar acf tmvs.tar.gz pkg

manual/index.html: pkg/inst/tmvs.m
	{ echo '\input texinfo' && \
	  echo '@macro qcode{x}' && \
	  echo '@code{\x\}' && \
	  echo '@end macro' && \
	  a='-\*- texinfo -\*-' && b='^\([^%]\|\)$$' && \
	  sed -n "/$$a/,/$$b/{/$$a/n;/$$b/q;s/^% \\?//p}" $< && \
	  echo '@bye' ; } | tee /tmp/pipe | makeinfo --html --output manual

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
