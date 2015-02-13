\NeedsTeXFormat{LaTeX2e}
\newcommand{\mse@classversion}{2.0}
\ProvidesPackage{./mse-template/mse-thesis}[2013/09/17 MSE Template LaTex, \mse@classversion]

% Options Definitions ######################################################

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	prefix=mse@option@
}

\DeclareStringOption[fr, en]{lang}
\DeclareStringOption[tic, tin]{major}
\DeclareStringOption[semester, thesis]{type}
\DeclareStringOption{path}
\DeclareBoolOption[false]{confidential}
\DeclareBoolOption[false]{skipbla}
\DeclareBoolOption[false]{draftversion}

\DeclareDefaultOption{
	\PassOptionsToClass{\CurrentOption}{report}
}

\ProcessKeyvalOptions*

\LoadClass[12pt, a4paper, titlepage]{report}

% Options Processing #######################################################

\RequirePackage[T1]{fontenc}
%\RequirePackage{pgfgantt}
\RequirePackage[utf8]{inputenc}
\RequirePackage[a4paper]{geometry} % geometry package makes texttt not breaking lines...
\RequirePackage{pdflscape}         % modify orientation of some pages
\RequirePackage{xspace}
\RequirePackage{graphicx}
\RequirePackage{anysize}
\RequirePackage[hyphens]{url}      % for the \path command, which breaks lines. Hyphen option allows to break after -
\RequirePackage{fancyhdr}
\RequirePackage[style=ieee, backend=biber]{biblatex}
\RequirePackage{csquotes}
\RequirePackage{setspace}
\RequirePackage{booktabs}          % for midrule, bottomrule
\RequirePackage{tabularx}          % more powerful tabular env
\RequirePackage{enumitem}          % allows parsep customization
\RequirePackage{float}             % to place figure exactly where code is
%\RequirePackage[section]{placeins} % force floating figures to appear in related section
\RequirePackage[toc]{glossaries}   % package for glossaries / acronyms
\RequirePackage[margin=1cm]{caption} % customize caption
\RequirePackage{soul}              % strike text
\RequirePackage{placeins}          % adds the floatbarrier command


% Special quotes 
% (have to be included before todonotes => dependency on xcolor)
\input{\mse@option@path/mse-thesis-quotes}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% draft and redaction helpers
\ifmse@option@draftversion
  \newcommand{\td}[1]{\todo[inline]{#1}}
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%% draft and redaction helpers
  \RequirePackage{todonotes}
  \RequirePackage[color,notref,notcite]{showkeys} %\[notref,notcite]
  \definecolor{refkey}{gray}{.45}
  \definecolor{labelkey}{gray}{.45}
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\else
  \newcommand{\todo}{}
  \newcommand{\td}[1]{}
  \newcommand{\missingfigure}{}
\fi

\RequirePackage{upquote}           % to get normal single quotes in listings
\RequirePackage{listings}

%%%% (almost) LAST PACKAGE TO INCLUDE
\RequirePackage{hyperref}          % create hyperlinks in document
%%%%

% after hyperref
\RequirePackage{cleveref}

\ifnum\pdf@strcmp{\mse@option@lang}{fr}=0
	\RequirePackage[frenchb]{babel}
    \input{\mse@option@path/mse-thesis-fr.lang}
\else
	\RequirePackage[english]{babel}
    \input{\mse@option@path/mse-thesis-en.lang}
\fi

\ifnum\pdf@strcmp{\mse@option@type}{semester}=0
	\newcommand{\mse@type}{\mse@str@semester}
\else
	\newcommand{\mse@type}{\mse@str@thesis}
\fi

\ifnum\pdf@strcmp{\mse@option@major}{tic}=0
	\newcommand{\mse@major}{\mse@str@tic}
\else
	\newcommand{\mse@major}{\mse@str@tin}
\fi



% Commands Definitions #####################################################

% add glossaries to toc
\glstoctrue

% clear a double page for a new chapter - when there isn't any content in a page, this
% would automaticly clear headers
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{
  \clearpage
  {\pagestyle{empty}\origdoublepage}
}

% table of contents helper
% force toc page style -- http://tex.stackexchange.com/questions/5787/table-of-contents-with-page-style-empty
\addtocontents{toc}{\protect\thispagestyle{fancy}}
\newcommand{\inserttoc}{
  % backup parskip set by user
  \let\beforetocparskip\parskip
  \setlength{\parskip}{0pt plus .1pt}

  \setcounter{tocdepth}{2}
  \tableofcontents
  \clearemptydoublepage
  
  % restore parskip
  \setlength{\parskip}{\beforetocparskip}
}

% list of figure helper
\newcommand{\insertlof}{
  \newpage
  \phantomsection
  \addcontentsline{toc}{chapter}{\listfigurename}
  \listoffigures\thispagestyle{fancy}
}

% list of table helper
\newcommand{\insertlot}{
  \newpage
  \phantomsection
  \addcontentsline{toc}{chapter}{\listtablename}
  \listoftables\thispagestyle{fancy}
}

% list of listening helper
\newcommand{\insertlol}{
  \newpage
  \phantomsection
  \addcontentsline{toc}{chapter}{\lstlistlistingname}
  \lstlistoflistings\thispagestyle{fancy}
}

% bibliography helper
\newcommand{\insertbibliography}{
  %\nocite{*} % include no-cited bib entry in biblio
  \newpage
  \phantomsection
  \begingroup
  \raggedright
  \sloppy
  \printbibliography[heading=bibintoc]
  \endgroup
  \thispagestyle{fancy}
}


% glossaries helper
\newcommand{\insertglossaries}{
  \newpage
  \phantomsection
  % \glsaddall % if we want all entries in glossary
  \printglossary\thispagestyle{fancy}
}


% More Package Setup #######################################################

% group listings into the table of listing by chapter
\let\Chapter\chapter
\def\chapter{\addtocontents{lol}{\protect\addvspace{10pt}}\Chapter}

% cref for listings
\crefname{lstlisting}{listing}{listings}
\Crefname{lstlisting}{Listing}{Listings}

% proper header height
\setlength{\headheight}{15pt}

% set custom parskip values
\setlength{\parindent}{0pt}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}
\setlist[itemize]{parsep=0pt}
\setlist[enumerate]{parsep=0pt}

% no vertical stretch
\raggedbottom

% generate glossaries
\makeglossaries

% eliminate space inserted before itemize
\setlist{nolistsep}

% Title Page ###############################################################
\input{\mse@option@path/mse-thesis-cover.cls}
\input{\mse@option@path/mse-thesis-bla.cls}

\AtBeginDocument{
  \mse@cover
  
  \ifmse@option@draftversion
    \listoftodos
  \fi
  
  \ifmse@option@skipbla \else
    \mse@bla
  \fi

  \pagestyle{fancy}
  %avoid section title in header
  \fancyhead[LE,RO]{}
  \fancyfoot{}
  \fancyfoot[LE,RO]{\thepage}
  \fancyfoot[LO]{\mse@author} %\ --- \@title}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0.4pt}

\endinput
}
