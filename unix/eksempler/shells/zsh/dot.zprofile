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
# This file: ~/.zprofile (4)
#
#-----------------------------------------------------------------------------
#--  Secure X server:

if [ ! "${DISPLAY}" = "" ]; then
   xhost -
fi

#-----------------------------------------------------------------------------
