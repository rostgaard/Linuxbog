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
# This file: ~/.zlogin (8)
#
#-----------------------------------------------------------------------------
#--  Keep an eye on people:

watch=(1 theboss       any \
         onefriend     any \
         anotherfriend any )

#-----------------------------------------------------------------------------
#--  Earlier logins:

last ${USER} | head -n 5

#-----------------------------------------------------------------------------
#--  Additional modifications to the keyboard map in X:

if [ -r "${HOME}/.xmodmaprc" ]; then
   xmodmap ${HOME}/.xmodmaprc
fi

#-----------------------------------------------------------------------------
