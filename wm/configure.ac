dnl Linuxbog.dk - autoconf script til at lave l�kre makefiler med (krydser fingre).
dnl Version 0.01 - Mads Bondo Dydensborg, mads@dydensborg.dk

AC_INIT(ophavsret.sgml)
AM_INIT_AUTOMAKE(linuxbog,1)

dnl ======================================================================
dnl Options
dnl ======================================================================

dnl Om der skal anvendes links til f.eks. html udgaven. (pdf anvender
dnl altid links nu).
dnl Args. er omvendt her, fordi den oprindeligt hed --enable-softlink, og jeg
dnl er doven.
AC_ARG_ENABLE(softlink,  [  --disable-softlink       Bruger softlinks til html formatet],
                         [enable_softlink=nej], [enable_softlink=ja])

dnl Om submit boksen skal med (p� tyge kun) i html udgaven
AC_ARG_ENABLE(submitbox,  [  --enable-submitbox      Tilf�jer en submit boks, n�r der bygges p� tyge],
                          [enable_submitbox=ja], [enable_submitbox=nej])



dnl ======================================================================
dnl Check for programmer, mv, der skal bruges
dnl ======================================================================

dnl Vi skal lede efter de programmer og filer, vi skal bruge under overs�ttelsen
AC_MSG_NOTICE([checker helt n�dvendige programmer og filer])
FATALE_MANGLER=""
dnl Vi har brug for perl
AC_CHECK_PROG(PERL, perl, ja, nej)
if test "xja" != "x$PERL" ; then
  FATALE_MANGLER="$FATALE_MANGLER perl"
  AC_MSG_NOTICE([perl blev ikke fundet. Det er n�dvendigt for at lave b�gerne at perl bliver installeret])
fi

dnl Vi har i den grad brug for jade
AC_CHECK_PROG(JADE, jade, ja, nej)
if test "xja" != "x$JADE" ; then
  FATALE_MANGLER="$FATALE_MANGLER jade/openjade"
  AC_MSG_NOTICE([jade blev ikke fundet. jade eller openjade er kr�vet for at lave b�g
erne og et af disse programmer skal installeres])
fi

dnl Vi bruger jw til at kalde jade
AC_CHECK_PROG(JW, jw, ja, nej)
if test "xja" != "x$JW" ; then
  FATALE_MANGLER="$FATALE_MANGLER jw"
  AC_MSG_NOTICE([jw blev ikke fundet. Det er n�dvendigt at installere dette progrm for at lave b�gerne])
fi

dnl find ogs�
AC_CHECK_PROG(FIND, find, ja, nej)
if test "xja" != "x$FIND" ; then
  FATALE_MANGLER="$FATALE_MANGLER find"
  AC_ERROR([find blev ikke fundet. find er kr�vet for at lave b�gerne og skal installeres])
fi

dnl ======================================================================
dnl Check stien til "cygnus" filerne
dnl ======================================================================


dnl ======================================================================
dnl Check generelle programmer der betyder noget for de enkelte pakker.
dnl Faktisk er de kr�vet pt, men det kan vi jo h�be �ndrer sig
dnl ======================================================================

AC_MSG_NOTICE([checker for generelle programmer])
ANBEFALEDE_MANGLER=""

AC_CHECK_PROG(TAR, tar, ja, nej - det er ikke muligt at lave tarrede udgaver)
if test "xja" != "x$TAR" ; then
  ANBEFALEDE_MANGLER="$ANBEFALEDE_MANGLER tar"
fi

AC_CHECK_PROG(ZIP, zip, ja, nej - det er ikke muligt at lave zippede udgaver)
if test "xja" != "x$ZIP" ; then
  ANBEFALEDE_MANGLER="$ANBEFALEDE_MANGLER zip"
fi

dnl ======================================================================
dnl Check specifikke krav til de enkelte m�der at lave bogen p�
dnl ======================================================================
AC_MSG_NOTICE([checker specifikke krav til de enkelte m�der at lave bogen p�])
dnl Til at starte med antager vi at alt kan laves. Hep, man er vel optimist.
TARGET_SGML=ja
TARGET_PALM=ja
TARGET_PDF=ja
TARGET_HTML=ja
TARGET_PAKHTML=ja

dnl ======================================================================
dnl Check krav til SGML udgaven
dnl ======================================================================
if test "xja" != "x$TAR" ; then 
  TARGET_SGML=nej
  AC_MSG_WARN(tar ikke fundet - det er ikke muligt at lave SGML udgaven)
fi
if test "xja" != "x$ZIP" ; then 
  TARGET_SGML=nej
  AC_MSG_WARN(zip ikke fundet - det er ikke muligt at lave SGML udgaven)
fi

dnl ======================================================================
dnl Check krav til HTML udgaven
dnl ======================================================================
AC_CHECK_PROG(DB2HTML, db2html, ja, nej - det er ikke muligt at lave HTML udgaven)
if test "xja" != "x$DB2HTML"; then
  TARGET_HTML=nej
else
  dnl Har vi tidy installeret?
  AC_CHECK_PROG(TIDY, tidy, ja, nej - du b�r installere tidy for at f� en p�nere HTML udgave)
  if test "xja" != "x$TIDY" ; then
    ANBEFALEDE_MANGLER="$ANBEFALEDE_MANGLER tidy"
  fi
  dnl Check for imagesize
  AC_MSG_CHECKING(om perl modulet Image::Size er installeret)
  if perl -e "use Image::Size;" 2> /dev/null ; then 
    HAVE_PERL_IMAGE_SIZE=ja
    AC_MSG_RESULT(ja)
  else
    HAVE_PERL_IMAGE_SIZE=nej
    AC_MSG_RESULT(nej - overvej at installer det for p�nere HTML udgave)
    ANBEFALEDE_MANGLER="$ANBEFALEDE_MANGLER tidy"
  fi
fi

dnl ======================================================================
dnl Check krav til PAKHTML udgaven
dnl ======================================================================
if test "xja" != "x$TARGET_HTML" ; then
  TARGET_PAKHTML=nej
  AC_MSG_WARN(HTML ikke muligt - det er ikke muligt at lave PAKHTML udgaven)
fi
if test "xja" != "x$TAR" ; then 
  TARGET_PAKHTML=nej
  AC_MSG_WARN(tar ikke fundet - det er ikke muligt at lave PAKHTML udgaven)
fi
if test "xja" != "x$ZIP" ; then 
  TARGET_PAKHTML=nej
  AC_MSG_WARN(zip ikke fundet - det er ikke muligt at lave PAKHTML udgaven)
fi

dnl ======================================================================
dnl Check krav til pdf udgaven
dnl ======================================================================
AC_CHECK_PROG(DB2PDF, db2pdf, ja, nej - det er ikke muligt at lave PDF udgaven)
if test "xja" != "x$DB2PDF"; then
  TARGET_PDF=nej
  AC_MSG_WARN([ db2pdf er ikke fundet - kan derfor ikke bygge pdf-filer ])
fi
AC_CHECK_PROG(PDFINFO, pdfinfo, ja, nej - det er ikke muligt at lave PDF udgaven)
if test "xja" != "x$PDFINFO"; then
  TARGET_PDF=nej
  AC_MSG_WARN([ pdfinfo (fra xpdf-pakken) er ikke fundet - kan derfor ikke bygge pdf-filer ])
fi
dnl Image Magick Convert
AC_CHECK_PROG(CONVERT, convert, ja, nej - det er ikke muligt at lave PDF udgaven)
if test "xja" != "x$CONVERT"; then
  TARGET_PDF=nej
  AC_MSG_WARN([ convert (ImageMagick) er ikke fundet - kan derfor ikke bygge pdf-filer ])
fi
if test "xja" != "x$TAR" ; then 
  TARGET_PDF=nej
  AC_MSG_WARN(tar ikke fundet - det er ikke muligt at lave PDF udgaven)
fi
dnl ======================================================================
dnl Check krav til Palm udgaven
dnl ======================================================================
if test "xja" != "x$TARGET_HTML" ; then
  TARGET_PALM=nej
  AC_MSG_WARN(HTML ikke muligt - det er ikke muligt at lave PALM udgaven)
fi
AC_CHECK_PROG(PLUCKER, plucker-build, ja, nej - det er ikke muligt at lave PALM udgaven)
if test "xja" != "x$PLUCKER"; then
  TARGET_PALM=nej
fi


dnl ======================================================================
dnl Lad brugeren vide lidt om hvad der foreg�r
dnl ======================================================================
AC_MSG_NOTICE([==================================================================])
if test "x$ANBEFALEDE_MANGLER" != "x" ; then
  AC_MSG_NOTICE([F�lgende programmer kan med fordel installeres for at f� flere muligheder for at bygge b�gerne: $ANBEFALEDE_MANGLER])
fi

if test "x$FATALE_MANGLER" != "x" ; then
  AC_ERROR([F�lgende programmer mangler for overhovedet at kunne bygge b�gerne og skal installeres: $FATALE_MANGLER])
fi

AC_MSG_NOTICE([Oversigt over hvilke moduler der kan laves])

AC_MSG_NOTICE([ Kan SGML bygges    : $TARGET_SGML ])
AC_MSG_NOTICE([ Kan PALM bygges    : $TARGET_PALM ])
AC_MSG_NOTICE([ Kan PDF bygges     : $TARGET_PDF ])
AC_MSG_NOTICE([ Kan HTML bygges    : $TARGET_HTML ])
AC_MSG_NOTICE([ Kan PAKHTML bygges : $TARGET_PAKHTML ])

AC_MSG_NOTICE([==================================================================])

dnl S�t nogen conditionals der bestemmer hvilke muligheder vi har for at bygge 
dnl de forskellige typer af bogen.
AM_CONDITIONAL(USE_SOFTLINKS, test "x$enable_softlink"  = "xja")

# Vi kan kun tilf�je submitbox, hvis vi har tidy
if test "xja" = "x$enable_submitbox" ; then
  if test "xja" != "x$TIDY" ; then
    AC_MSG_NOTICE([For at kunne bruge --enable-submitbox, skal tidy v�re installeret (submitbox ikke enablet)])
    AM_CONDITIONAL(ADD_SUBMITBOX, false)
  else 
    AM_CONDITIONAL(ADD_SUBMITBOX, true)
  fi
else
    AM_CONDITIONAL(ADD_SUBMITBOX, false)
fi


AM_CONDITIONAL(BUILD_SGML,    test "x$TARGET_SGML"      = "xja")
AM_CONDITIONAL(BUILD_PALM,    test "x$TARGET_PALM"      = "xja")
AM_CONDITIONAL(BUILD_PDF,     test "x$TARGET_PDF"       = "xja")
AM_CONDITIONAL(BUILD_HTML,    test "x$TARGET_HTML"      = "xja")
AM_CONDITIONAL(BUILD_PAKHTML, test "x$TARGET_PAKHTML"   = "xja")

AM_CONDITIONAL(HAVE_TIDY,     test "x$TIDY" = "xja")
AM_CONDITIONAL(HAVE_PERL_IMAGE_SIZE, test "x$HAVE_PERL_IMAGE_SIZE" = "xja")

AC_CONFIG_FILES(Makefile)
AC_OUTPUT
