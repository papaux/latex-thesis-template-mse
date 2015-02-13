# MSE Thesis Template LaTeX

LaTeX template for MSE semester and thesis reports.

This template is based on the template provided by Nicolas Jakob with some customization.
You may find useful information in his original repo: https://github.com/njakob/template-latex/

This template adds following features to the original template:
* Reworked cover page
* Makefile for generating the document
* Variables extracted in thesis-var.tex file
* Compile-to-RAMdisk option (to preserve your SSD from some write access, and for fun :-) )

## Pre-requisite

This template makes use of various latex tools. Ensure that you have:
* A Linux system if you wan't to use all the nice features of this template :-)
* latexmk
* biber
* make
* A /tmp folder mounted as ramdisk if you want to take benefit of RAM compilation

I use a custom latexmk configuration stored in ~/.latexmkrc.

Create the file and copy this content:


    # makeglossaries
    add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
    add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
    
    sub run_makeglossaries {
       my ($base_name, $path) = fileparse( $_[0] );
       pushd $path;
       my $return = system "makeglossaries $base_name";
       popd;
       return $return;
    }
    push @generated_exts, 'glo', 'gls', 'glg';
    push @generated_exts, 'acn', 'acr', 'alg';
    $clean_ext .= ' %R.ist %R.xdy';
    
    # clean .bbl (biber backend of biblatex)
    $bibtex_use = 2;
    
    # moar clean
    $clean_ext .= " run.xml synctex.gz lol";


## Getting started

This template comes with a Makefile for easy document generation.

Two targets can be used:
* ```make pdf-ram``` if you want to use ram compilation
* ```make pdf-noram``` if you prefer to compile in the current folder

The default target is pdf-ram. Just run:

```
make
```

Note for RAM compilation:
* the compilation time should not change that much... you just save some writes on your SSD :-)
* you need a /tmp folder mounted as RAMdisk. If yours is not a RAMdisk, compilation should work but will be run on the local drive.
* the generated files (pdf, synctex, logs, etc.) are symlink to your /tmp folder. If you reboot, they will be lost!


### Configure No-RAM Compilation as default

The default make target is for RAM compilation. You can modify this by editing the Makefile and replace:

```
all: pdf-ram
```

with

```
all: pdf-noram
```

For comparison, the compilation times on my Laptop are:



| Type | Time [s] |
| -----|-----------
| SSD compilation | 3.473 |
| HDD compilation | 3.499 |
| RAMdisk compilation | 3.450 |

So, no real win in terms of compilation time for RAMdisk, but it still saves some write on your SSD device :-)


## LaTeX dev environment advices

For LaTeX developmenet on Linux, I'm using **LaTeXila**. It's a nice editor based on gedit but dedicated to LaTeX development and provides a lot of nice features.
Thanks to Sébastien Wilmet, the developer of this tool!

If you want to use the Makefile with LaTeXila, and have LaTeXila parsing the build errors, open the menu Build -> Manage Build Tools.

Then add a new Build Tool with following parameters:
* Extensions: .tex
* Add a first job:
** command: make env
** post processor: no-outputlat
* Add a second job
** command: latexmk -pdf -e '$pdflatex=q/pdflatex %O -synctex=1 %S/' -outdir=./bin $filename
** post processor: latexmk


You could also add a less verbose version of the previous command:
* latexmk -pdf -silent -e '$pdflatex=q/pdflatex %O -synctex=1 %S/' -outdir=./bin $filename

You could also add a clean target:
* Extensions: leave empty
* Add one job:
** command: make clean
** post processor: no-output
