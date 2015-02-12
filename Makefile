master = "thesis"
bin = "bin"
ramdisk = "/tmp/ramdisk/mse-thesis-build/"


all: pdf-ram

pdf-ram: env pdf
pdf-noram: env-noram pdf

env: env-ram

env-ram:
	mkdir -p $(ramdisk)$(bin)
	ln -fs $(ramdisk)$(bin)
	ln -fs ./$(bin)/$(master).log $(master).log
	ln -fs ./$(bin)/$(master).pdf $(master).pdf
	ln -fs ./$(bin)/$(master).synctex.gz $(master).synctex.gz

env-noram:
	mkdir -p $(bin)
	ln -fs ./$(bin)/$(master).log $(master).log
	ln -fs ./$(bin)/$(master).pdf $(master).pdf
	ln -fs ./$(bin)/$(master).synctex.gz $(master).synctex.gz


pdf:
	latexmk -pdf -e '$$pdflatex=q/pdflatex %O -interaction=nonstopmode -synctex=1 %S/' -outdir=./$(bin) $(master).tex


clean:
	latexmk -c
	find . -type f -name "*~" -exec rm {} \; # Gedit backup files
	rm -fr $(bin)/*
	rm -fr $(bin)
	rm -f $(master).pdf

.PHONY: env pdf clean all env-ram env-noram pdf-ram pdf-noram

