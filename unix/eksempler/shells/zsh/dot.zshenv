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
# This file: ~/.zshenv (2)
#
# Stuff that should be available from the KDE mini command line, as well as to
# non-interactive programs should be defined here.
#
#-----------------------------------------------------------------------------
#--  Command path:

foreach directory ( "${HOME}/bin" \
                    /bin /usr/bin /usr/local/bin \
                    /sbin /usr/sbin /usr/local/sbin \
                    /usr/bin/X11 /usr/X11R6/bin \
                    /usr/local/netpbm )
   if [ -d "${directory}" ]; then
      export PATH=`echo "${PATH}" | sed "s,:${directory}:,:,g" \
                                  | sed "s,^${directory}:,,g" \
                                  | sed "s,:${directory}"'$,,g'`:${directory}
   fi
end

#-----------------------------------------------------------------------------
#--  Prevent core dumps:

limit coredumpsize 0

#-----------------------------------------------------------------------------
#--  Locale:

export LANG=da_DK.ISO8859-1

export LESSCHARSET=latin1
export MM_CHARSET=ISO-8859-1

#-----------------------------------------------------------------------------
#--  Printer preferences:

export PRINTER=pscats

#-----------------------------------------------------------------------------
#--  Editor preferences:

export EDITOR=emacs

#-----------------------------------------------------------------------------
#--  Main mail archive:

export MAIL=${HOME}/Mail/ANDET

#-----------------------------------------------------------------------------
#--  Processorantal:

case "${HOST}" in
   (my.big.fancy.multiprocessor.machine)
      processor_count=2
   ;;
   (*)
      processor_count=1
   ;;
esac

#-----------------------------------------------------------------------------
#--  HTML Tidy (configuration file):

export HTML_TIDY=${HOME}/.tidyrc

#-----------------------------------------------------------------------------
#--  Allow CVS to use SSH:

export CVS_RSH=ssh

#-----------------------------------------------------------------------------
#--  Determine display and font size:
   
if [ "${DISPLAY}" = "" ]; then
   export DISPLAY_WIDTH=0
else
   # The display on "sparre.nbi.dk" is only 1024 pixels wide

   if [ "${HOST}" = "sparre.nbi.dk" -a "${DISPLAY}" = ":0.0" ]; then
      export DISPLAY_WIDTH=1024
   elif [ "${HOST}" = "sparre.nbi.dk" -a "${DISPLAY}" = ":0" ]; then
      export DISPLAY_WIDTH=1024
   else
      export DISPLAY_WIDTH=1280
   fi
fi

if [ -e ${HOME}/.demo_mode ]; then
   # Use a very large font if the file "~/.demo_mode" exists.

   font_selection='-fn 10x20'
elif [ "${DISPLAY_WIDTH}" = "1280" ]; then
   font_selection='-fn 7x13'
else 
   font_selection=''
fi

#-----------------------------------------------------------------------------
#--  Xterm (color):
   
if [ -x /usr/X11R6/bin/xterm-color -o -x /usr/bin/X11/xterm-color ]; then
   alias xterm="xterm-color ${font_selection} -ls -sb -rw -aw -sl 256 +vb +mb -bg \#ffffc0 -fg \#a00000 -T $HOST -n $HOST"
else
   alias xterm="\xterm      ${font_selection} -ls -sb -rw -aw -sl 256 +vb +mb -bg \#ffffc0 -fg \#a00000 -T $HOST -n $HOST"
fi

#-----------------------------------------------------------------------------
#--  Xload:

alias xload='\xload ${font_selection} -bg \#ffffc0 -fg \#a00000'

#-----------------------------------------------------------------------------
#--  Giving Emacs some nice colours:

alias emacs="\emacs ${font_selection} -bg \#ffffc0 -fg \#a00000"

#-----------------------------------------------------------------------------
#--  Make Licq run with the QT GUI:

if [ -x /usr/bin/licq -o -x /usr/local/bin/licq ]; then
    alias licq="licq -p `locate licq_qt-gui.so`"
fi

#-----------------------------------------------------------------------------
#--  Aliases and environment variables for the LEGO building instruction
#--  renderer LDGLite:

if [ -x ${HOME}/bin/ldglite -o -x /usr/local/bin/ldglite -o -x /usr/bin/ldglite -o ]; then
   if [ -d /usr/share/ldraw ]; then
      export LDRAWDIR=/usr/share/ldraw
   elif [ -d /usr/local/share/ldraw ]; then
      export LDRAWDIR=/usr/local/share/ldraw
   fi

   alias  ldglite-front-left-above='ldglite -a1,0,1,0.5,1,-0.5,-1,0,1'
   alias ldglite-front-right-above='ldglite -a1,0,-1,-0.5,1,-0.5,1,0,1'
   alias ldglite-front-right-below='ldglite -a-1,0,1,-0.5,-1,-0.5,1,0,1'
   alias   ldglite-rear-left-above='ldglite -a-1,0,1,0.5,1,0.5,-1,0,-1'
   alias  ldglite-rear-right-above='ldglite -a-1,0,-1,-0.5,1,0.5,1,0,-1'
   alias  ldglite-rear-right-below='ldglite -a1,0,1,-0.5,-1,0.5,1,0,-1'
fi

#-----------------------------------------------------------------------------
