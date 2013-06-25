# Any .tex files in the top-level directory will be converted into pdfs,
# this gives us a list of the pdfs that will be created so that the rules
# below can work out which ones are missing.
PDFS=$(addsuffix .pdf, $(basename $(wildcard *.tex)))

# Any files in code/ will be syntax highlighted and output into
# build/code/foo.rb.tex so you can \input{build/code/foo.rb} from
# the top-level files.
CODES=$(addprefix build/, $(addsuffix .tex, $(wildcard code/*)))

# images should go in img/, and any extra .tex files you need can
# go into the include/ directory. When anything changes in these
# directories we'll rebuild the pdfs (whether or not that's actually
# necessary).
IMAGES=$(wildcard img/*)
INCLUDES=$(wildcard include/*)

# The default thing to do is to make all the pdfs from tex files.
all: $(PDFS)

# To make foo.pdf from foo.tex, whenever any file changes use lualatex in the
# build directory and copy the finally copy the resulting pdf to the top level.
%.pdf: %.tex $(CODES) $(IMAGES) $(INCLUDES)
	mkdir -p build
	lualatex -output-directory build $<
	cp build/$@ .

# This line stops the highlighted code from being `rm -rf`d by make.
# It thinks they are just intermediate files, but as they take time
# to make, we'd rather keep them.
# http://www.gnu.org/software/make/manual/html_node/Chained-Rules.html
.SECONDARY:

# To make foo.rb.tex from foo.rb pygmentize it.
# Stashes the result in the build directory to avoid filesystem pollution.
build/code/%.tex: code/%
	mkdir -p build/code
	pygmentize -f latex $< > $@

# Clean all teh things.
clean:
	rm -rf build/ *.pdf
