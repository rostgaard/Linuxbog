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
#--  Window titles:

if [ "$TERM" = "xterm" ]; then
   alias vinduestitel='echo -n "]2;\!*"'
   alias    ikontitel='echo -n "]1;\!*"'
   alias        titel='ikontitel \!*; vinduestitel \!*'

   # \!* does not work in Zsh. :-(

   alias vinduestitel='echo Vinduestitel:'
   alias    ikontitel='echo Ikontitel:'
   alias        titel='echo Ikon- og vinduestitel:'
else
   alias vinduestitel='true'
   alias    ikontitel='true'
   alias        titel='true'
fi

#-----------------------------------------------------------------------------
#--  Mail clients:

alias   elm='titel Postkasse;      \elm \!*;      titel $HOST'
alias  elmf='titel Postkasse: \!*; \elm -f =/\!*; titel $HOST'
alias  pine='titel Postkasse;      \pine \!*;     titel $HOST'
alias pinef='titel Postkasse: \!*; \pine -f \!*;  titel $HOST'

# \!* does not work in Zsh. :-(

unalias elm
unalias elmf
unalias pine
alias   pinef='pine -f'

alias    Merete='pinef merete.lillemark'
alias    Rachid='pinef rachid.el.mousti'
alias       Far='pinef morten.sparre.andersen'
alias      Hans='pinef hans.schou'
alias    Jesper='pinef jesper.holm.villaume.lauritsen'
alias Christian='pinef christian.i.mikkelsen'
alias  Caroline='pinef caroline.sparre.higuchi'

#-----------------------------------------------------------------------------
#--  Set window title when editing with vi:

alias vi='vindues_titel Redigerer \!*; ikon_titel \!*; \vi \!*; titel ${HOST}: `pwd | sed '"'"'s,^.*\/,,'"'"'`'

# \!* does not work in Zsh. :-(

unalias vi

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

if [ -e ${HOME}/.ssh/identity.323 ]; then
   ssh_command="ssh -i ${HOME}/.ssh/identity.323"
else
   ssh_command="ssh"
fi

alias  kirstine="${ssh_command} sparre@scharff.fys.ku.dk"
alias     meyer="${ssh_command} sparre@scharff.fys.ku.dk"
alias   scharff="${ssh_command} sparre@scharff.fys.ku.dk"
alias  johansen="${ssh_command} sparre@scharff.fys.ku.dk"

alias       afs="${ssh_command} sparre@afs.nbi.dk"
alias       alf="${ssh_command} sparre@alf.nbi.dk"
alias      cats="${ssh_command} sparre@alf.nbi.dk"
alias    cradle="${ssh_command} sparre@kaoslx07.nbi.dk"
alias  acoustic="${ssh_command} sparre@kaoslx07.nbi.dk"
alias   floures="${ssh_command} sparre@kaoslx07.nbi.dk"
alias    sannux="${ssh_command} sparre@kaoslx07.nbi.dk"
alias     shaky="${ssh_command} sparre@kaoslx07.nbi.dk"
alias    kitten="${ssh_command} sparre@kaoslx07.nbi.dk"
alias     fritz="${ssh_command} sparre@kaoslx07.nbi.dk"
alias    hobbes="${ssh_command} sparre@kaoslx07.nbi.dk"
alias     pelle="${ssh_command} sparre@kaoslx07.nbi.dk"
alias  garfield="${ssh_command} sparre@kaoslx07.nbi.dk"

alias    sparre="${ssh_command}"' `cat ${HOME}/.sparre.nbi.dk`'

alias     munin="ssh sparre@munin.nbi.dk"

alias     sslug="ssh -i ${HOME}/.ssh/identity sparre@www.sslug.dk"
alias      tyge="ssh -i ${HOME}/.ssh/identity sparre@tyge.sslug.dk"

alias     hugin="echo 'sys-323.risoe.dk er afsat til anden side.'"
alias       323="echo 'sys-323.risoe.dk er afsat til anden side.'"

if [ $HOST = johansen.fys.ku.dk ]; then
   alias på_alle='(echo johansen:; \!*; echo garfield:; garfield \!*)'
elif [ $HOST = garfield.nbi.dk ]; then
   alias på_alle='(echo johansen:; johansen \!*; echo garfield:; \!*)'
else
   alias på_alle='(echo johansen:; johansen \!*; echo garfield:; garfield \!*)'
fi

alias      xafs='xterm -T afs      -e ssh sparre@afs.nbi.dk'
alias      xalf='xterm -T alf      -e ssh sparre@alf.nbi.dk'
alias xacoustic='xterm -T kaoslx07 -e ssh sparre@kaoslx07.nbi.dk'
alias   xcradle='xterm -T kaoslx07 -e ssh sparre@kaoslx07.nbi.dk'
alias  xfloures='xterm -T kaoslx07 -e ssh sparre@kaoslx07.nbi.dk'
alias    xpelle='xterm -T kaoslx07 -e ssh sparre@kaoslx07.nbi.dk'
alias xgarfield='xterm -T kaoslx07 -e ssh sparre@kaoslx07.nbi.dk'

alias xkirstine="xterm -T johansen -e ssh -i ${HOME}/.ssh/identity.323 sparre@johansen.fys.ku.dk"
alias    xmeyer="xterm -T johansen -e ssh -i ${HOME}/.ssh/identity.323 sparre@johansen.fys.ku.dk"
alias  xscharff="xterm -T johansen -e ssh -i ${HOME}/.ssh/identity.323 sparre@johansen.fys.ku.dk"
alias xjohansen="xterm -T johansen -e ssh -i ${HOME}/.ssh/identity.323 sparre@johansen.fys.ku.dk"

alias    xmunin="xterm -T munin    -e ssh sparre@munin.nbi.dk"

#-----------------------------------------------------------------------------
#--  World Wide Web:

if [ $?DISPLAY ]; then
   #alias oser 'netscape \!* &'
   alias oser='\lynx -noreferer -pseudo_inlines +image_links'
else
   alias oser='\lynx -noreferer -pseudo_inlines +image_links'
fi

alias lynx='\lynx -noreferer -pseudo_inlines +image_links'

alias             AllTheWeb='oser "http://www.alltheweb.com/cgi-bin/search?type=all&query=\!*&exec=FAST+Search"'
alias             Altavista='AllTheWeb'
alias               oversæt='oser http://babelfish.altavista.digital.com/cgi-bin/translate\?'
alias                  LEGO='oser http://www.lego.com/'
alias                AdaLRM='oser http://www.adahome.com/rm95/'
alias Retskrivningsordbogen='oser http://www.dsn.dk/cgi-bin/ordbog/ro96'
alias         Risø-adresser='oser http://www.risoe.dk/phone/afd.htm'
alias                 Pause='oser http://www.lugnet.com/pause/search'
alias                 Scope='oser http://www.scope.dk/'
alias            Filmlisten='oser http://www.scope.dk/lister/filmliste.php3'
alias          Telefonbogen='oser http://www.009.dk/privat.asp'
alias           Rejseplanen='oser http://www.rejseplanen.dk/servlet/rp.central.RPServlet/tekst_indtastning.htm'
alias               Øresund='oser http://www.dsb.dk/oeresund/koreplan.htm'

alias      Bobby='oser "http://udl.cast.org/bobby?URL=\!*&browser=AccEval&Text-only=on&output=Submit"'
alias HTML-check='oser "http://validator.w3.org/check?url=\!*"'

alias ro='oser "http://www.dsn.dk/cgi-bin/ordbog/ro96?M=1&P=`echo "\!*" | sed "/æ/s/æ/%E6/g" | sed "/ø/s/ø/%F8/g" | sed "/å/s/å/%E5/g"`"'

#-----------------------------------------------------------------------------
#--  HTML Tidy (aliases):

alias         tidy-check='clear; (tidy \!* > /dev/null) |& head -n 20'
alias           tidy-fix='tidy -mq \!*'
alias check_and_fix_HTML='(tidy-check \!* && tidy-fix \!* && echo O.k.) || vi \!*'

#-----------------------------------------------------------------------------
#--  X Windows:

#alias X       '\X :3.0 -terminate -query alf.nbi.dk'
#alias X-8bit  '\X :3.0 -terminate -query alf.nbi.dk -bpp 8'
#alias X-16bit '\X :3.0 -terminate -query alf.nbi.dk -bpp 16'
#alias X-24bit '\X :3.0 -terminate -query alf.nbi.dk -bpp 24'

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
else
   alias po_spell="echo 'Pospell er ikke installeret på denne maskine.'"
   alias po_stave="echo 'Pospell er ikke installeret på denne maskine.'"
   alias po_stava="echo 'Pospell er ikke installeret på denne maskine.'"
fi

#-----------------------------------------------------------------------------
#--  LaTeX:

if [ -x /usr/local/bin/latex2e -o -x /usr/bin/latex2e ]; then
   alias latex=latex2e
fi

alias              dvi2ps="dvips \!* -o"
alias komplet_opfriskning="latex \!*; makeindex \!*; bibtex \!*; latex \!*; latex \!*; dvi2ps \!*"

#-----------------------------------------------------------------------------
#--  Postscript and printing:

alias  pnm2ps='pnmtops -width 8.26 -height 11.69'
alias  gif2ps='(giftopnm | pnm2ps)'
alias jpeg2ps='(djpeg    | pnm2ps)'
alias  png2ps='(pngtopnm | pnm2ps)'

alias       man2ps='(man \!* | a2ps --catman --output=- --header="Manual for \!*" --center-title="\!*" --left-footer="Printed by %n@%M")'
alias man2colourps='(man \!* | a2ps --catman --output=- --header="Manual for \!*" --center-title="\!*" --left-footer="Printed by %n@%M" --prologue=color)'

alias   ps2psbook="(psbook | psnup -2 | tumble)"
alias ps2A5-hæfte="(psbook -s8 | psnup -4 )"

#-----------------------------------------------------------------------------
#--  Image processing:

alias ppm2jpeg='cjpeg'
alias  gif2png='(giftopnm | pnmtopng)'
alias  gif2grå='(giftopnm | ppmtopgm)'

if [ -e ~/Baggrunde/signatur-43x30.pgm ]; then
   alias sign_image='pnmpaste -replace ~/Baggrunde/signatur-43x30.pgm -43 -30'
else
   alias sign_image="Echo didn't find a signature to insert."
fi

#-----------------------------------------------------------------------------
#--  Time and date stuff:

alias      date='\date +"%Y-%m-%d"'
alias        kl='\date +"%H:%M"'
alias godmorgen='echo "echo 'Du skal hjem nu' | elm -s Fyraften mig >& /dev/null" | \at -c now + 444 min'

#-----------------------------------------------------------------------------
#--  Fra SSLUG's julekalender 1999:

#alias udregn='gawk -v CONVFMT="%13.6f" -v OFMT="%.9g" "BEGIN{  print !* }"'
#alias   in_k='udregn (\!* + 512) / 1024 | cut -d'.' -f1'

#-----------------------------------------------------------------------------
#--  Ada (GNAT):

#j_flag='-j'`udregn ${processor_count} * 2`
jflag=-j2

alias         gm="gnatmake ${j_flag} -m \!* -cargs -gnatv -gnati1 -gnatf -gnato -fstack-check"
alias  gm-static="gnatmake ${j_flag} -m \!* -cargs -gnatv -gnati1 -gnatf -gnato -fstack-check -bargs -static"
alias gm-testing="gnatmake ${j_flag} -m \!* -cargs -gnatv -gnati1 -gnatf -gnato -fstack-check -g -gnata -gnatO -gnatwa -gnatq -gnatU"

alias gm-fast='echo -O3 -funroll-loops -funwind-tables -gnatn'

unset j_flag

#-----------------------------------------------------------------------------
#--  Find information om en maskine:

alias tjek_maskine='(host \!*;nslookup \!*;whois \!*;traceroute \!*)|&m'

# \!* doesn't work in Zsh. :-(

unalias tjek_maskine

#-----------------------------------------------------------------------------
#--  Fjern overforbrug af nutids-r'er:

alias nutids-r="perl -w -pe 'use strict; use locale; s/(\W(at|vil|ville|kan|kunne|skal|skulle|må|måtte) \w+)r(\W)/"'$1$3'"/gim'"

#-----------------------------------------------------------------------------
#--  Arkiver fra synkronisering:

alias vis_arkiver='ls ~/temp/*.zip ~/.trashcan/*.zip ~/.uploaded/*.zip ~/.downloaded/*.zip'

#-----------------------------------------------------------------------------
#--  Sæt vinduestitel til katalogets navn ved katalogskift:

if [ "${TERM}" = "xterm" ]; then
   alias cd='cd \!*; titel ${HOST}: `pwd | sed '"'"'s,^.*\/,,'"'"'`'

   # \!* doesn't work in Zsh. :-(

   unalias cd
fi

#-----------------------------------------------------------------------------
#--  RPM-genveje:

if [ -x /usr/bin/rpm ]; then
   alias pakkestørrelser='rpm -qa --queryformat="%10{SIZE}\t%{NAME}-%{VERSION}-%{RELEASE}\n" | sort -nr'
fi

#-----------------------------------------------------------------------------
#--  System status:

case "${HOST}" in
   (munin.nbi.dk|sparre.nbi.dk)
      alias Status='titel Status for $HOST ; cl ; lastusers ; echo "" ; df -k ; echo "" ; free'
   ;;
   (*.fys.ku.dk)
      alias Status='titel Status for $HOST ; cl ; lastusers ; echo "" ; df -k ~/ ~/scratch/ ; echo "" ; free; echo ""; quota'
   ;;
   (*.nbi.dk)
      alias Status='titel Status for $HOST ; cl ; lastusers ; echo "" ; df -k ; echo "" ; free; echo ""; quota'
   ;;
   (*)
      echo "Does not know what to do to show the system status for ${HOST}."
      alias Status='echo "No status information for ${HOST}."'
   ;;
esac

#-----------------------------------------------------------------------------
#--  Miscellaneous machine specific aliases:

if [ "${HOST}" = "munin.nbi.dk" ]; then
   alias m=less
else
   alias m=more
fi

#-----------------------------------------------------------------------------
#--  Der er problemer med `quota` på alf:

if [ "${HOST}" = "alf.nbi.dk" ]; then
   alias quota='ssh afs.nbi.dk quota'
fi

#-----------------------------------------------------------------------------
#--  Miscellaneous aliases:

# alias cwdcmd 'echo -n "]2;${HOST}:$cwd]1;$cwd"'
# alias dis 'echo setenv DISPLAY $DISPLAY; echo export DISPLAY=$DISPLAY'
alias    vt='export TERM=vt100; export LINES=24; resize'
alias     c='cat'
alias     h='history'
alias rydop='\rm -i *.log *.dvi *.bak *~ *.tmp #*#'
alias    rm='\rm -i'
alias    cl='clear'
alias    md='mkdir'
alias    rd='rmdir'

alias      ws='rwho | cut -d" " -f1 | sort -u | m'
alias frokost='ws | grep -f ~/Blandet/frokostklubben | m'


alias httplog='(echo "www.nbi.dk:"; alf ls -Flrt /www/WWW/log/ | grep "httpd.log." | tail -n 5; ls -Flrt ~/Web-stats/alf/ | tail -n 5; echo "fys.ku.dk:"; kirstine ls -Flrt /usr/local/mosaic-offentlig/statistik/logfiler/; ls -Flrt ~/Web-stats/meyer/ | tail -n 5) | m'


alias til_jacob='echo "\!*" | elm -s "fra Jacob" sparre@cats.nbi.dk >& /dev/null'

alias rgrep='find . -name \* -print | xargs grep '

alias adresser='unzip -ap ~/Blandet/Adresser/arkiv Jacob.text|m'

alias    noter='vi ~/Blandet/noter'
alias kalender='cat ~/Blandet/Huskesedler/????-??-??'

#-----------------------------------------------------------------------------
#--  Oprydning af "dead.letter":

if [ -e ~/dead.letter ]; then
   mv ~/dead.letter ~/.dead_letter.`date`
fi

#-----------------------------------------------------------------------------
#--  Oprydning efter Netscape:

if [ -e ~/nsmail ]; then
   true
   #rm -rf nsmail
fi

#-----------------------------------------------------------------------------
