#!/bin/sh
exec guile -s "$0" -- "$@"
!#
; af Peter Stubbe <stubbe@bitnisse.dk>
; $Id$
; Programmet er skrevet til Guile
;
; Afvikling:
;  ./udskriv.scm [fil]+

(define args (command-line))
(define fnavn "")
(define fil "")
(define lnr 0)
(define lin "")

(while (not (string=? "--" (car args)))
    (set! args (cdr args)))
(set! args (cdr args))

(while (not (null? args))
    (set! fnavn (car args))
    (set! args (cdr args))

    (cond ((not (zero? (system (string-append "test -r " fnavn))))
            (display "Filen ")(display fnavn)(display " findes ikke!\n"))
        (t (set! fil (open-input-file fnavn))
            (set! lnr 1)
            (set! lin (read-line fil))
            (while (not (eof-object? lin))
                (display lnr)(display "\t")(display lin)(display "\n")(set! lnr (+ lnr 1))
                (set! lin (read-line fil)))
            (close-input-port fil)))

    (cond ((char-ready?) (cond ((char=? #\Q (read-char)) (exit)))))
)
(while #t
    (cond ((char-ready?)
        (cond ((char=? #\Q (read-char)) (exit))))))
