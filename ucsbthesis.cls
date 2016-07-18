% UCSB thesis document class
%    for LaTeX version 2e - 2014/09/11
% Most recent editor: Daniel Sank
% adapted from M. G. Neeley's mgnthesis.cls
% inspired by John T. Whelon's Jucthesis.cls
% which in turn derives from ucthesis.sty

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucsbthesis}[2014/09/11 UCSB thesis]

% derive from the book class
\LoadClassWithOptions{book}

% set up the page geometry per UCSB thesis guidelines
\RequirePackage[top=1.0in,bottom=1.0in,
                inner=1.25in,outer=1.0in,
                includehead,footskip=0.25in,
                marginparwidth=1.0in,marginparsep=0.1in]{geometry}

% "intelligent" double-spacing
\RequirePackage{setspace}

% make sure that equation* and eqnarray* environments are defined
\RequirePackage{amsmath}

% command that lets us patch existing environments, so they can be used with the standard names
% an environment called 'env' is implemented internally by defining two commands,
% \env and \endenv.  To patch the environment, we first capture the current def's
% of these commands into new variables called \old@env and \endold@env.  Then, we
% renew the environment, adding the patches before and after the beginning and end,
% respectively.  We use \begin and \end as usual, but call the old environment,
% as it was when we captured the previous definition.  To properly capture the
% old definitions requires a bit of magic using \csname + \endcsname to construct
% the command names like \old@env from the specified arguments, and \expandafter
% to control the order of macro expansion.  \sarcasm{Yeah, TeX!}
\newcommand{\PatchEnvironment}[5]{
  \expandafter\let\csname old@#1\expandafter\endcsname\csname #1\endcsname\relax
  \expandafter\let\csname endold@#1\expandafter\endcsname\csname end#1\endcsname\relax
  \renewenvironment{#1}{#2\begin{old@#1}#3}{#4\end{old@#1}#5}
}


% option 'doublespace'
\DeclareOption{doublespace}{
  \setstretch{2.0}
  
  % redefine equation and eqnarray environments to be single-spaced
  \PatchEnvironment{equation}{\par\begingroup\setstretch{1.0}}{}{}{\endgroup}
  \PatchEnvironment{equation*}{\par\begingroup\setstretch{1.0}}{}{}{\endgroup}
  \PatchEnvironment{eqnarray}{\par\begingroup\setstretch{1.0}}{}{}{\endgroup}
  \PatchEnvironment{eqnarray*}{\par\begingroup\setstretch{1.0}}{}{}{\endgroup}
  %\PatchEnvironment{multline}{\par\begingroup\setstretch{1.0}}{}{}{\endgroup}
}


% option 'colorlinks'
\newcommand{\@linkcolor}{black}
\newcommand{\@citecolor}{black}
\DeclareOption{colorlinks}{
  \renewcommand{\@linkcolor}{blue}
  \renewcommand{\@citecolor}{red}
}


% option 'nosigs'
\newif\if@sigs
\@sigstrue
\DeclareOption{nosigs}{
  \@sigsfalse
}


\ProcessOptions


% use the natbib package for easier bibliography customization
% we modify bibliography to be single spaced and include line in table of contents
\RequirePackage{natbib}
\let\old@bibpreamble\bibpreamble
\renewcommand{\bibpreamble}{\old@bibpreamble\singlespacing\addcontentsline{toc}{chapter}{\bibname}}


% make sure index gets included properly in table of contents
\RequirePackage{makeidx}
\PatchEnvironment{theindex}{}{\number\thepage\addcontentsline{toc}{chapter}{\indexname}}{}{}


% include hyperref package, but make sure it is the last thing to be imported
\AtBeginDocument{
  \RequirePackage[
    pdftitle={\@title},
    pdfauthor={\@author},
    hyperindex=true,
    plainpages=false, % use roman numerals for frontmatter, arabic for body text
    pdfpagelabels, % make pdf page labels show up as roman numerals for frontmatter
    colorlinks=true,
    linkcolor=\@linkcolor, % color of links to other parts of text
    citecolor=\@citecolor, % color of links to bibliography entries
  ]{hyperref}
}


% utility command to show the definition of a macro
% the definition is printed in the console output, not in the document itself
% this stops the processing of the document, so this may be useful for debugging,
% but not for actually including stuff in the body of the document itself
% usage: \shown{mymacro}
\newcommand{\shown}[1]{\expandafter\show\csname#1\endcsname}


% levels of toc hierarchy to show in table of contents
\setcounter{tocdepth}{2}

% number equations as X.Y where X is chapter and Y is section
\AtBeginDocument{\numberwithin{equation}{chapter}}


% structured part names
\renewcommand\contentsname{Contents}
\renewcommand\partname{Part}
\renewcommand\chaptername{Chapter}
\renewcommand\appendixname{Appendix}
\renewcommand\bibname{Bibliography}
\renewcommand\indexname{Index}

\renewcommand\listfigurename{List of Figures}
\renewcommand\listtablename{List of Tables}
\renewcommand\figurename{Figure}
\renewcommand\tablename{Table}

\newcommand\abstractname{Abstract}
\newcommand\acknowledgename{Acknowledgements}
\newcommand\noteforthereadername{Note for the reader}
\newcommand\vitaename{Curriculum Vit\ae}


% DECLARATIONS
%
% These macros declare arguments needed for the
% construction of the front matter.  

\newcommand{\approvalmonth}[1]{\gdef\@approvalmonth{#1}}
\newcommand{\degreemonth}[1]{\gdef\@degreemonth{#1}}
\newcommand{\degreeyear}[1]{\gdef\@degreeyear{#1}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}
\newcommand{\field}[1]{\gdef\@field{#1}}
\newcommand{\campus}[1]{\gdef\@campus{#1}}

\newcommand{\chair}[1]{\gdef\@chair{#1}}
\newcommand{\experimentalmember}[1]{\gdef\@experimentalmember{#1}}
\newcommand{\theorymember}[1]{\gdef\@theorymember{#1}}
\newcommand{\othermembers}[1]{\gdef\@othermembers{#1}}

\newcommand{\@numberofmembers}{3}
\newcommand{\@approvalspace}{.75in}
\newcommand{\@signaturelinewidth}{4.0in}

\newcommand{\numberofmembers}[1]{
\gdef\@numberofmembers{#1}
\ifnum \@numberofmembers > 3
  \gdef\@approvalspace{.5in}
\fi
}


% alwaysonecol environment
%
% Defines an environment for front matter that is always one column 
% even in a two-column document.  Also ends with a new page.

\newenvironment{alwaysonecol}{
\@restonecolfalse
\if@twocolumn
  \@restonecoltrue\onecolumn
\else
  \newpage
\fi
}{
\if@restonecol
  \twocolumn
\else
  \newpage
\fi
}


% Fonts to be used in the front matter headings
%\newcommand{\fmheader}{\fontfamily{cmss}\fontseries{bx}\fontsize{17}{19}\selectfont}
% I think the cmss font looks silly, so let's not use it - DTS 2014
\newcommand{\fmheader}{\fontseries{bx}\fontsize{17}{19}\selectfont}

% TITLEPAGE
%
% \maketitle outputs the complete titlepage.  It requires all the
% above macros.  It is probably not correct for joint
% (e.g. UCSD/SDSU) degrees.

\renewcommand{\maketitle}{{
\renewcommand{\thepage}{\roman{page}}
\begin{alwaysonecol}
\begin{singlespace}
  \let\footnotesize\small
  \let\footnoterule\relax
  \thispagestyle{empty}

  \null\vfil
  \begin{center}
    UNIVERSITY of CALIFORNIA \par
    \@campus \par
    
    \bigskip \medskip
    \vspace{6ex}
    {\bf \@title} \par
    \bigskip \medskip
    
    \vspace{6ex}
    A dissertation submitted in partial satisfaction of the \par
    \smallskip
    requirements for the degree of \par

    \bigskip
    {\@degree} \par
    \bigskip \medskip
    in \par
    \bigskip \medskip
    {\@field}\par
    \bigskip \medskip
    by \par
    \bigskip \medskip
    {\@author} \par

    \if@sigs
      \vspace{6ex}
      Committee in charge:
      \begin{doublespace}
        \begin{quote}
          \begin{center}
          \@chair, Chair \\
          \@experimentalmember \\
          \@theorymember
          \end{center}
        \end{quote}
      \end{doublespace}
    \else
      \vspace{12ex}
    \fi
    \@degreemonth~\@degreeyear
  \end{center}
  \vfil\null
\end{singlespace}
\end{alwaysonecol}
}}


% APPROVALPAGE
%
% The \approvalpage macro emits a UC-approved approval page ready for
% your committee's signature.  It is not an automatic part of the 
% output because there's really no point in printing it until you are
% ready to get signatures.  It requires the the \year, \author, and
% \campus macros have been defined.  It uses lots of tricky spacing
% that is probably better handled with tabular environment code, but
% I'm too lazy to fix it. (EVM, 9/19/94)

\newcommand{\@signatureline}[1]{
  \vspace{\@approvalspace}
  \begin{center} \underline{~~~~ \hspace{\@signaturelinewidth} ~~~~} \end{center}
  \vspace{-0.15in} \hspace{0.6in} {\small #1} \\
}

\newcommand{\approvalpage}{
\cleardoublepage
\begin{singlespace}
\begin{alwaysonecol}
  \thispagestyle{empty}
  \null\vfill
  \begin{center}
    The dissertation of {\@author} is approved: \\
    \vspace{.25in}
  \end{center}

  \@signatureline{\@experimentalmember}
  \@signatureline{\@theorymember}
  \@signatureline{\@chair, Chair}

  \vspace{-0.25in}
  \vspace{\@approvalspace}
  \begin{center} \@approvalmonth~\@degreeyear \end{center}
  \vfill\null
\end{alwaysonecol}
\end{singlespace}
}


% COPYRIGHTPAGE
%
% While it's technically optional, you probably want a copyright page.
% This is a macro, not an environment, because it can be generated
% with the \title, \author, and \year macros.

\newcommand{\copyrightpage}{
\cleardoublepage
\begin{singlespace}
\begin{alwaysonecol}
  \begin{center}
    \null\vspace{6.5in}\par
    Copyright \copyright\ \@degreeyear\par
    by \@author
  \end{center}
\end{alwaysonecol}
\end{singlespace}
}


% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}{
\cleardoublepage
\begin{singlespace}
\begin{alwaysonecol}
  \null\vfil
  \begin{center}
    \large
}{
  \end{center}
  \vfil\null
\end{alwaysonecol}
\end{singlespace}
}


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}{
\cleardoublepage
\begin{singlespace}
\begin{alwaysonecol}
  \begin{center}
    {\fmheader \acknowledgename}
  \end{center}
}{
\end{alwaysonecol}
\end{singlespace}
}

% NOTES FOR THE READER

\newenvironment{noteforthereader}{
\cleardoublepage
\begin{singlespace}
\begin{alwaysonecol}
 \begin{center}
  {\fmheader \noteforthereadername}
 \end{center}
}{
\end{alwaysonecol}
\end{singlespace}
}


% ABSTRACT
%
% The ABSTRACT environment allows for multi-page abstracts which,
% in accordance with UC rules, is numbered separately from the rest
% of the rest of the dissertation in Arabic.  It requires definition
% of the \title and \author macros.

\newenvironment{abstract}{
\cleardoublepage
\begin{alwaysonecol}
  \begin{center}
    {\fmheader \abstractname}\par
    \vspace{.5in}
    {\bf \@title}\par
    \vspace{.1in}
    by\par
    \vspace{.1in}
    \@author\par
    \vspace{.1in}
  \end{center}
}{
  \par\vfil\null
\end{alwaysonecol}
}


% VITAE
%
% The vitae environment puts a large, bold, centered 
% "Curriculum Vitae" label at the top of the page.

\newenvironment{vitae}{
\cleardoublepage
\begin{singlespace}
\begin{alwaysonecol}
  \begin{center}
    {\fmheader \vitaename}\par
    \vspace{1em}
    {\large \@author}
    \vspace{1.5em}
  \end{center}
  \begin{list}{}{\leftmargin 0in \itemsep 2em}
}{
  \end{list}
\end{alwaysonecol}
\end{singlespace}
}

%\newcommand{\vitaesecttitle}{\fontfamily{cmss}\fontseries{bx}\fontsize{13pt}{14pt}\selectfont}
\newcommand{\vitaesecttitle}{\bf}
\newcommand{\vitaelabels}[1]{#1 \hfil}

\newenvironment{vitaesection}[1]{
\item {\vitaesecttitle #1}
\begin{list}{}{\leftmargin 1.2in \parsep 1em
               \labelwidth 1.0in \labelsep 0.2in
               \let\makelabel\vitaelabels}
}{
\end{list}
}

\newenvironment{vitaesectnodate}[1]{
\item {\vitaesecttitle #1}
\begin{list}{}{\leftmargin 0in \parsep 1em
               \labelwidth 1.2in \labelsep 0.2in
               \let\makelabel\vitaelabels}
}{
\end{list}
}


% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 2) for the front matter.
% It also resets page-numbering for
% the remainder of the dissertation (arabic, starting at 1).

\renewenvironment{frontmatter}{%
  \setcounter{page}{2} % title page included in numbering, so we start at 2 after that
  \renewcommand{\thepage}{\roman{page}} % frontmatter numbered in roman numerals
  \pagestyle{empty}
  \begin{alwaysonecol}
    \if@sigs
      \approvalpage
    \fi
    \cleardoublepage
    \pagestyle{plain} % start displaying page numbers after title and signature pages
    \copyrightpage
}{
  \end{alwaysonecol}
  \cleardoublepage
  \setcounter{page}{1} % restart page numbers for body text
  \renewcommand{\thepage}{\arabic{page}} % body numbered with arabic numerals
  \pagestyle{headings}
}


