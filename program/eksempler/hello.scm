#!/bin/sh
exec guile -s "$0"
!#
; af Peter Stubbe <stubbe@bitnisse.dk>
; $Id$

; Programmet er skrevet til Guile
;
; Afvikling:
;  ./hello.scm

(display "Hello, world!\n")
