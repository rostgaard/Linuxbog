C     Program smart.f
C     af Peter Gylling <gylling@danbbs.dk>
C     $Id$
C
C     Har du nogensinde undret dig over, hvilken acceleration
C     de vitale motordele i din bil/motorcykel/knallert/etc 
C     udsættes for ved forskellige omdrejnings tal? 
C
C     En undersøgelse af plejlstangs mekanismen vil være en 
C     opgave, der tidligere typisk ville blive skrevet i 
C     fortran. Idag vil det blive gjort i det programmerings 
C     sprog, som passer den enkelte bedst.
C
C     Plejlstangs mekanismen omsætter den roterende bevægelse,
C     som krumtap akselen udsættes for til stemplets bevægelse 
C     op/ned gennem cylinderen. Som følge af dette er stemplet
C     udsat for accelleration selvom motoren kører med konstant
C     omdrejningstal. Det vil føre for vidt her, at gennemgå 
C     de teoretiske overvejelser, der er nødvendige for en 
C     tilbunds gående undersøgelse.
C
C     Som input til programmet, så skal brugeren indtaste værdien
C     af de vigtigste variable:
C
C     N --> Omdrejningstal (omdr/min)
C     R --> Krumtappens radius (m)
C     L --> Længde af plejlstangen (m)
C
C     Som output skrives en datafil med følgende værdier:
C
C     Kolonne 1 --> Vinkel reference (løber fra 0 til 359 grader)
C     Kolonne 2 --> Stemplets position (m)
C     Kolonne 3 --> Stemplets hastighed (m/s)
C     Kolonne 4 --> Stemplets accelleration (m/s²)
C
C     Data kan så vises f.eks. ved brug af gnuplot eller octave
C
C     Skrevet af Peter Gylling
C     ---------------------------------------------------------------

      program acc
      implicit none

C     -------------------------------------------------------------
C     Det farlige ved fortran er, at der er en hel masse
C     forud definerede variable. Dette betyder, at programmet
C     fint kan kompilere selvom et par variable ikke er defineret.
C     Under brug kan det derfor være vanskeligt at finde ud af,
C     hvorfor der opstår underlige resultater.
C
C     Derfor benyttes her 'implicit none', der har som resultat,
C     at ingen variable må tages fra den forud definerede liste.
C     --------------------------------------------------------------


C     Definition af variable
C     ----------------------

      integer in_unit        ! Standard læsning fra tastatur
      integer out_unit       ! Standard skrivning til skærm
      integer fil_out_unit   ! Standard skrivning til fil

      integer i              ! Tæller 
      integer n_rpm          ! Omdrejnings tal (rpm)
      
      real*4 pi              ! Pi er her sat til 3.1416
      real*4 alpha           ! Vinkel reference (radianer)
      real*4 r_krum          ! Radius af krumtappen (m)
      real*4 l_plejl         ! Længde af plejlstangen (m)
      real*4 w               ! Rotationshastighed (radianer/sekund)
      real*4 kvad            ! Kvadrarods udtryk 
      real*4 data(4,360)     ! 4 kollonner af længde 360
      

C     Start på program
C     ----------------

      in_unit = 5
      out_unit = 6
      fil_out_unit = 16
      pi = 3.1416

C     Indlæsning af data fra bruger
C     -----------------------------
      write(out_unit,100) '>> Indtast omdrejningstal (omdr/min)' 
 100  format(3x,a)
      write(out_unit,105) '>> '
 105  format(3x,a3,$)           !$--> ingen linieskift
      read(in_unit,110) n_rpm
 110  format(i6)
      write(out_unit,100) '>> Indtast krumtap radius (m)'
      write(out_unit,105) '>> '
      read(in_unit,115) r_krum
 115  format(f8.6)
      write(out_unit,100) '>> Indtast plejlstangs længde (m)'
      write(out_unit,105) '>> '
      read(in_unit,115) l_plejl

C     Beregning af position,hastighed,accelleration.
C     Dette kunne ligeså godt skrives direkte ud i en fil,
C     men det bliver her vist ved, at oprette en matrice 
C     indeholdende de relevante data.
C
C     Som det vil kunne ses i datafilen, så er postitionen
C     af stemplet regnet som positiv i top død punktet (TDP),
C     hvorfor det afstedkommer en negativ accellerations kurve
C     samme sted.
C     ----------------------------------------------------

      w = (n_rpm/60)*2*pi

      do i=1,360
         data(1,i) = i-1
         alpha = i*(pi/180)
         kvad = sqrt(l_plejl*l_plejl - 
     &        0.5*r_krum*r_krum*(1-cos(2*alpha)) )
         data(2,i) = r_krum*cos(alpha) + kvad - l_plejl + r_krum
         data(3,i) = -w*( r_krum*sin(alpha) + 
     &        (r_krum*r_krum*sin(2*alpha))/(2*kvad))
         data(4,i) = -w*w*(r_krum*cos(alpha) +
     &        ( ((2*r_krum*r_krum*cos(2*alpha)*kvad) +
     &        (r_krum*r_krum*r_krum*r_krum*
     &        (1-cos(4*alpha))) / 4*kvad) /(4*kvad))
     &        )
      end do

C     Udskrivning af resultater til fil.
C     Der udskrives med kommentalinier i toppen af 
C     datafilen, så der er overblik over den.
C     Da programmer som gnuplot og octave læser
C     '%' tegn som starten på en kommentar linie vælges
C     dette tegn til at indikere kommentarer.
C     -------------------------------------------------

      open(fil_out_unit,file='datafil.m')
      
      write(fil_out_unit,150) '% datafil udskrevet fra acc.f'
 150  format(a)
      write(fil_out_unit,150) '%'
      write(fil_out_unit,150) 
     & '% Vinkel      Position      Hastighed      Accelleration'
      write(fil_out_unit,150)
     & '% Grader           (m)          (m/s)            (m/s^2)'  

      do i=1,360
         write(fil_out_unit,160) i,data(2,i),
     &        data(3,i),data(4,i)
      end do
 160  format(5x,i3,3x,e12.6,3x,e12.6,5x,e12.6)

      close(fil_out_unit)

C     Afslutning af program
      end
