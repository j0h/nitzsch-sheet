LATEX=pdflatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
TARGET=target
LATEXMKOPT=-pdf -jobname=$(TARGET)/out
CONTINUOUS=-pvc

MAIN=paper
SOURCES=$(MAIN).tex $(shell find . | grep *.tex)
#FIGURES := $(shell find figures/* images/* -type f)

all:    $(MAIN).pdf

.refresh:
	touch .refresh
###
##
$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

force:
	touch .refresh
	rm $(MAIN).pdf
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
	$(LATEXMK) -C $(MAIN)
	rm -rf $(TARGET)/*pdf
	rm -f $(MAIN).pdfsync
	rm -rf $(TARGET)/*~ $(TARGET)/*.tmp
	rm -f $(TARGET)/*.bbl $(TARGET)/*.blg $(TARGET)/*.aux $(TARGET)/*.end $(TARGET)/*.fls $(TARGET)/*.log $(TARGET)/*.out $(TARGET)/*.fdb_latexmk

once:
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force once all

