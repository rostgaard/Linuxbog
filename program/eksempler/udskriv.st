" af Peter Stubbe <stubbe@bitnisse.dk>
  $Id$
  Programmet er skrevet til GNU-SmalllTalk
  http://www.gnu.org/software/smalltalk/smalltalk.html

  Afvikling:
   gst -Q udskriv.st -a [fil]+
"

Smalltalk at: #fil put: 0!
Smalltalk at: #fnr put: 0!
Smalltalk at: #lin put: 0!
Smalltalk at: #lnr put: 0!

1 to: Smalltalk arguments size do: [:fnr |
 (File exists: (Smalltalk arguments at: fnr))
  ifFalse: [stdout nextPutAll: (Smalltalk arguments at: fnr).
            stdout nextPutAll: ' findes ikke!'.
            stdout nl
  ]
  ifTrue:  [fil:=FileStream open: (Smalltalk arguments at: fnr) mode: #read.
            lnr:=0.
            [fil atEnd] whileFalse: [lnr:=lnr+1.
                                     lin:=fil nextLine.
                                     lnr printOn: stdout.
                                     stdout tab.
                                     stdout nextPutAll: lin.
                                     stdout nl
            ]
  ]
]!
