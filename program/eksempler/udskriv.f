C       Program eksemplet udskriv fil.
C       af Peter Gylling <gylling@danbbs.dk>
C       $Id$
C 
C       Bemærk: Programmet kan ikke stoppes ved at taste 'Q', da denne
C       feature ligepræcis udtrykker problemet med fortran77. Det kan 
C       ikke læse fra to enheder samtidig. Fortran77 er og bliver et
C       sprog, der er udviklet til numeriske beregninger af diverse
C       naturvidenskablige problemer.
C       
C       Kompile: g77 -o udskriv udskriv.f
C
C       Afvikling: ./udskriv

        program udskriv 
        implicit none

C       Erklæring af variable
        integer i               
        integer input_unit
        integer output_unit
        integer file_unit

        character*60 file_name
        character*80 file_line

        logical file_exist
        logical file_open


C       Program start
        input_unit = 5          ! Standard læsning fra tastatur
        output_unit = 6         ! Standard skrivning til skærm
        file_unit = 15          ! Standard læsning fra fil

        write(output_unit,100) '>> Indtast filnavn' 
 100    format(3x,a)
        write(output_unit,105) '>> '
 105    format(3x,a3,$)         !$--> ingen linieskift
        read(input_unit,110) file_name
 110    format(a60)

C       Tjek om filen eksisterer
        inquire(file=file_name,exist=file_exist,opened=file_open)
        
C       Hvis file_ok = TRUE, så eksisterer filen
C       Hvis file_open = TRUE, så er filen åbnet
        
        if(file_exist) then
           i = 1
           if(file_open) goto 200
           open(file_unit,file=file_name)
           goto 200
        else
           goto 400
        end if

C       Filen er nu åbnet og klar til indlæsning
 200    continue
        
        read(file_unit,205,end=250)  file_line
 205    format(a80)
C       Udskrift til skærm
        write(output_unit,210) i,file_line
 210    format(3x,'>> ',i3,' ',a70)

C       Forhøjer linietælleren
        i = i+1
        goto 200

C       Afslutter udskrift på grund af 'End Of File'
 250    continue
        write(output_unit,405) '[EOF] --> Udskrivning afsluttes'
        close(file_unit)
        goto 500
              
C       Filen eksisterer ikke fejlmeddelelse udskrives
 400    continue
        write(output_unit,405) '[FEJL] --> Filen eksisterer ikke'
 405    format(3x,'>> ',a)
        goto 500
        
 500    continue
        write(output_unit,405) 'Programmet afsluttes'

C       Afslutning af programmet
        end
