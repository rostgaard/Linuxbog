#!/usr/bin/scriba
rem af Peter Stubbe <stubbe@bitnisse.dk>
rem $Id$

rem Programmet er skrevet til Basic-dialekten ScriptBasic
rem http://www.scriptbasic.com
rem
rem Afvikling:
rem  ./udskriv.bas fil+

args=command()
i=instr(args, " ")
if isdefined(i) then
 fil=left(args, i-1)
else
 fil=args
endif
while fil<>""
 args=right(args, len(args)-i)
 if isfile(fil)=0 then
  print fil, " findes ikke!\n"
 else
  open fil for input as 1
  lnr=1
  line input #1, a
  while a<>""
   print lnr, "\t", a
   lnr=lnr+1
   line input #1, a
  wend
  close 1
 endif
 i=instr(args, " ")
 if isdefined(i) then
  fil=left(args, i-1)
 else
  fil=args
 endif
wend
