version=1.0.0

build: check package document

document: data-flow.png data-flow.tex manual/index.html manual.pdf

package: tmvs-$(version).tar.gz

check: CSVParser.class NameParser.class mock/Main

clean:
	$(RM) *.java *.tokens mock/*.hi mock/*.o mock/Main
	$(RM) *.log *.texinfo *.toc
	$(RM) tmvs.tar.gz

deep-clean: clean
	$(RM) *.class
	$(RM) *.png *.tex
	$(RM) manual.pdf
	$(RM) -r manual
	$(RM) *.tar.gz
	$(RM) *.tmp

install: tmvs-$(version).tar.gz
	octave-cli --norc --quiet --eval 'pkg install $<'

uninstall:
	octave-cli --norc --quiet --eval 'pkg uninstall tmvs'

tmvs-$(version).tar.gz: tmvs.tar.gz
	octave-cli --norc --quiet --eval 'pkg build . tmvs.tar.gz'

tmvs.tar.gz: pkg pkg/* pkg/inst/*
	tar --auto-compress --create --file tmvs.tar.gz \
	--transform 's|^\./|pkg/inst/|' pkg ./excerpt ./*.g4 ./*.txt

manual.pdf: tmvs.texinfo data-flow.png
	makeinfo --pdf --output manual.pdf $<

manual/index.html: tmvs.texinfo data-flow.png
	makeinfo --html --output manual $<
	cp data-flow.png manual

tmvs.texinfo: pkg/inst/*.m
	{ echo '\input texinfo' && \
	  cat macros.texi && \
	  echo '@set helppages' && \
	  a='-\*- texinfo -\*-' && b='^\([^%]\|\)$$' && \
	  for x in $$(find pkg/inst -name 'tmvs.m' && \
	  find pkg/inst -name '*.m' -not -name 'tmvs.m' | LC_ALL=C sort) ; \
	  do sed -n "/$$a/,/$$b/{/$$a/n;/$$b/q;s/^% \\?//p}" "$$x" ; done && \
	  echo '@bye' ; } > $@

%.tex: %.dot
	dot2tex --codeonly --format tikz --texmode verbatim -o $@ $<

%.png: %.dot
	dot -Efontname=sans -Gfontname=sans -Nfontname=sans \
	-Tpng -Gsize=6,12 $< > $@

mock/Main: mock/Main.hs
	ghc -imock Main

%.class: %.java
	javac $<

%Parser.java: %.g4
	antlr4 $<
