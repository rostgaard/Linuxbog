#!/bin/sh
exec rep "$0" "$@"
!#
; af Peter Stubbe <stubbe@bitnisse.dk>
; $Id$

; Programmet er skrevet til rep
;
; Afvikling:
;  udskriv.lisp [fil]+

(while (not (null command-line-args))
  (cond
   ((file-exists-p (car command-line-args))
    (setq fil (open-file (car command-line-args) 'read))
    (setq lnr 1)
    (while  (setq lin (read-line fil))
      (princ lnr)
      (setq lnr (+ lnr 1))
      (princ "\t")
      (princ lin)
      )
    (close-file fil)
    (setq command-line-args (cdr command-line-args))
    t)
   (t
    (princ "Filen ")(princ fnavn)(princ " findes ikke!\n")))
  (princ "\n")
  )
