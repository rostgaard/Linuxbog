#-----------------------------------------------------------------------------
# Zsh start up sequence:
#
# 1) /etc/zshenv   (login + interactive + other)
# 2)   ~/.zshenv   (login + interactive + other)
# 3) /etc/zprofile (login)
# 4)   ~/.zprofile (login)
# 5) /etc/zshrc    (login + interactive)
# 6)   ~/.zshrc    (login + interactive)
# 7) /etc/zlogin   (login)
# 8)   ~/.zlogin   (login)
#
# This file: ~/.zshrc (6)
#
#-----------------------------------------------------------------------------
# The following lines were added by compinstall

autoload -U compinit
compinit

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle :compinstall filename '/home/cmplx/sparre/.zshrc'

# End of lines added by compinstall
#-----------------------------------------------------------------------------
#--  Command line prompt:

export  PS1='[%@] %M:%% '
export RPS1='%~'

#-----------------------------------------------------------------------------
#--  Directory listings:

alias ll='ls -Fl'
alias ls='ls -F'

#-----------------------------------------------------------------------------
#--  Head and tail:

foreach nr (  1  2  3  4  5  6  7  8  9 10 \
             11 12 13 14 15 16 17 18 19 20 \
             21 22 23 24 25 26 27 28 29 30 \
             31 32 33 34 35 36 37 38 39 40 \
             41 42 43 44 45 46 47 48 49 50 )
   alias h${nr}="head -n ${nr}"
   alias t${nr}="tail -n ${nr}"
end

#-----------------------------------------------------------------------------
#--  Remote shells:

alias  sslug='ssh www.sslug.dk'
alias   tyge='ssh tyge.sslug.dk'

alias xsslug='xterm -T sslug -e ssh www.sslug.dk'
alias  xtyge='xterm -T tyge  -e ssh tyge.sslug.dk'

#-----------------------------------------------------------------------------
#--  World Wide Web:

alias lynx='lynx -noreferer -pseudo_inlines +image_links'

alias               oversæt='lynx http://babel.altavista.com/tr\?'
alias                  LEGO='lynx http://www.lego.com/'
alias                AdaLRM='lynx http://www.adahome.com/rm95/'
alias Retskrivningsordbogen='lynx http://www.dsn.dk/\?/cgi-bin/ordbog/ronet'
alias                 Scope='lynx http://www.scope.dk/'
alias           Rejseplanen='lynx http://www.rejseplanen.dk/bin/query.exe/mn'
alias               Øresund='lynx http://www.dsb.dk/oeresund/koreplan.htm'

#-----------------------------------------------------------------------------
#--  Spell checking:

if [ -x /usr/bin/aspell -a -e /usr/lib/aspell/british ]; then
   alias spell="aspell --lang=british  check"
else
   alias spell="ispell -d british            -C -L -b -S -w'áðèíóúæøåÁÐÍÓÚÆØÅéÉäÄöÖüÜ'"
fi

if [ -x /usr/bin/aspell -o -x /usr/local/bin/aspell ]; then
   alias stave="aspell --lang=dansk    check"
   alias stava="aspell --lang=føroyskt check"
else
   alias stave="ispell -d dansk              -C -L -b -S -w'áðèíóúÁÐÍÓÚéÉäÄöÖüÜ'"
   alias stava="ispell -d ~/.ispell/føroyskt -C -L -b -S -w'áðèíóúÁÐÍÓÚéÉäÄöÖüÜ'"
fi

alias     word="echo '\!*' | ispell -d british               -a -C -L -b -S -w'áðèíóúÁÐÍÓÚéÉäÄöÖüÜæøåÆØÅ'"
alias      ord="echo '\!*' | ispell -d dansk                 -a -C -L -b -S -w'áðèíóúÁÐÍÓÚéÉäÄöÖüÜ'\'"

if [ -e /usr/lib/ispell/føroyskt.hash ]; then
   alias   orð="echo '\!*' | ispell -d føroyskt           -a -C -L -b -S -w'áðèíóúÁÐÍÓÚéÉäÄöÖüÜ'\'"
else
   alias   orð="echo '\!*' | ispell -d ~/.ispell/føroyskt -a -C -L -b -S -w'áðèíóúÁÐÍÓÚéÉäÄöÖüÜ'\'"
fi

if [ -x /usr/bin/pospell -o -x /usr/local/bin/pospell ]; then
   alias po_spell='\pospell -n \!* -p aspell -- --lang=british  check %f'
   alias po_stave='\pospell -n \!* -p aspell -- --lang=dansk    check %f'
   alias po_stava='\pospell -n \!* -p aspell -- --lang=føroyskt check %f'
fi

#-----------------------------------------------------------------------------
#--  Postscript and printing:

alias  pnm2ps='pnmtops -width 8.26 -height 11.69'
alias  gif2ps='(giftopnm | pnm2ps)'
alias jpeg2ps='(djpeg    | pnm2ps)'
alias  png2ps='(pngtopnm | pnm2ps)'

alias   ps2psbook="(psbook | psnup -2 | tumble)"
alias ps2A5-hæfte="(psbook -s8 | psnup -4 )"

#-----------------------------------------------------------------------------
#--  Image processing:

alias ppm2jpeg='cjpeg'
alias  gif2png='(giftopnm | pnmtopng)'
alias  gif2grå='(giftopnm | ppmtopgm)'

if [ -e ${HOME}/images/signature-43x30.pgm ]; then
   alias sign_image='pnmpaste -replace ${HOME}/images/signature-43x30.pgm -43 -30'
fi

#-----------------------------------------------------------------------------
#--  Time and date stuff:

alias      date='\date +"%Y-%m-%d"'
alias        kl='\date +"%H:%M"'
alias godmorgen='echo "echo 'Du skal hjem nu' | elm -s Fyraften mig >& /dev/null" | \at -c now + 444 min'

#-----------------------------------------------------------------------------
#--  GNU Ada (GNAT):
#--
#--  Typical use:
#--
#--    gm ada_source_file.adb `gm-flags-default`

alias gm='gnatmake -j2 -m'

alias gm-flags-default='-cargs -gnatv -gnati1 -gnatf -gnato -fstack-check'
alias  gm-flags-static='-cargs -gnatv -gnati1 -gnatf -gnato -fstack-check \
                        -bargs -static'
alias gm-flags-testing='-cargs -gnatv -gnati1 -gnatf -gnato -fstack-check \
                        -g -gnata -gnatO -gnatwa -gnatq -gnatU'
alias    gm-flags-fast='-O3 -funroll-loops -funwind-tables -gnatn \
                        -cargs -gnatv -gnati1 -gnatf -gnato -fstack-check'

#-----------------------------------------------------------------------------
#--  Fjern overforbrug af nutids-r'er:

alias nutids-r="perl -w -pe 'use strict; use locale; s/(\W(at|vil|ville|kan|kunne|skal|skulle|må|måtte) \w+)r(\W)/"'$1$3'"/gim'"

#-----------------------------------------------------------------------------
#--  RPM-genveje:

if [ -x /usr/bin/rpm ]; then
   alias pakkestørrelser='rpm -qa --queryformat="%10{SIZE}\t%{NAME}-%{VERSION}-%{RELEASE}\n" | sort -nr'
fi

#-----------------------------------------------------------------------------
#--  Miscellaneous aliases:

alias    vt='export TERM=vt100; export LINES=24; resize'
alias     c='cat'
alias     m=more
alias     h='history'
alias rydop='\rm -i *.log *.dvi *.bak *~ *.tmp #*#'
alias    rm='\rm -i'
alias    cl='clear'
alias    md='mkdir'
alias    rd='rmdir'

alias      ws='rwho | cut -d" " -f1 | sort -u | m'

alias    noter='vi ~/Blandet/noter'

#-----------------------------------------------------------------------------
#--  Oprydning af "dead.letter":

if [ -e ~/dead.letter ]; then
   mv ~/dead.letter ~/.dead_letter.`date`
fi

#-----------------------------------------------------------------------------
