% Commands Definitions #####################################################

\renewcommand{\and}{\\\vspace{0.5em}}
\newcommand{\email}[1]{\\{\texttt{#1}}}
\newcommand{\institute}[1]{\unskip, \emph{#1}}

\newcommand{\mse@author}{\@empty}
\renewcommand{\author}[1]{
   \renewcommand{\mse@author}{#1}
}
\newcommand{\mse@contact}{\@empty}
\newcommand{\contact}[1]{
   \renewcommand{\mse@contact}{{\texttt{#1}}}
}

\newcommand{\mse@professor}{\@empty}
\newcommand{\professor}[1]{
   \renewcommand{\mse@professor}{#1}
}

\newcommand{\mse@orderer}{\@empty}
\newcommand{\orderer}[1]{
   \renewcommand{\mse@orderer}{#1}
}

\newcommand{\mse@expert}{\@empty}
\newcommand{\expert}[1]{
   \renewcommand{\mse@expert}{#1}
}

\newcommand{\mse@proposedby}{\@empty}
\newcommand{\proposedby}[1]{
   \renewcommand{\mse@proposedby}{#1}
}

\newcommand\mse@version{\@empty}
\newcommand{\version}[1]{
   \renewcommand{\mse@version}{#1}
}

\newcommand\mse@headofmse{\@empty}
\newcommand{\headofmse}[1]{
   \renewcommand{\mse@headofmse}{#1}
}

\newcommand{\mse@location}{\@empty}
\newcommand{\location}[1]{
   \renewcommand{\mse@location}{#1}
}

\newcommand\mse@advisor{\@empty}
\newcommand{\advisor}[1]{
   \renewcommand{\mse@advisor}{#1}
}

%% outputs arguments in two columns, 1 is left and 2 is right content
\newcommand{\mse@twocolumn}[2]{
 \begin{minipage}[t]{0.45\textwidth}
    \begin{flushleft}{#1}\end{flushleft}
 \end{minipage}
 \hfill
 \begin{minipage}[t]{0.45\textwidth}
    \begin{flushright}{#2}\end{flushright}
 \end{minipage}
}


\newcommand{\mse@cover}{
   \pagestyle{empty}

   \begin{center}

     \includegraphics[width=250px]{\msepath/gfx/mse.eps}
     \vspace{\stretch{0.2}}
     
     \hrule

     \ifmse@option@confidential \MakeUppercase{\mse@str@confidential} \fi
     \vspace{\stretch{2}}

     {\large \bf Master of Science HES-SO in Engineering}\\[1.5ex]
     {\mse@str@major: \mse@major}
     
     \vspace{\stretch{2}}

     {\hrule\begin{flushright}\textbf{\huge{\@title}} \\
      \vspace{2ex} 
      \Large{\mse@type} \end{flushright}\hrule}
     

     \vspace{\stretch{0.75}} 

     \if\mse@location\@empty \else
        \begin{minipage}[c]{0.6\textwidth}
           \centering \mse@str@supportedby \emph{\mse@location}
        \end{minipage}\@empty
     \fi
     
     \vspace{\stretch{2}}

     {\large \mse@author}\\
     \mse@contact
     
     \vspace{\stretch{2}} 

     \mse@twocolumn
     {
         {\bf \mse@str@professor}\\
         \vspace{0.5em}
         \mse@professor\\
         \vspace{1em}
         \if\mse@orderer\@empty \else
           {\bf \mse@str@orderer}\\
           \vspace{0.5em}
           \mse@orderer
         \fi

     }
     {
         {\bf Expert}\\
         \vspace{\stretch{0.5}}
         \mse@expert\\
     }

     \vspace{\stretch{3}}

     \mse@twocolumn
     {}
     {
       HES-SO//Master\\
     \ifmse@option@draftversion 
       [DRAFT]\\
     \else
       \mse@version\\
     \fi
      
       \@date\\
     }

    \vfill
    \hrule
    \vspace{\stretch{0.2}}
    \includegraphics[height=80px]{\msepath/gfx/hesso.eps}

   \end{center}  
   \cleardoublepage
}
