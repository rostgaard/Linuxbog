{
  udskriv.pas
  af Michael Rasmussen <mir@miras.org>
  $Id$

  Oversæt med: gpc udskriv.pas -o udskriv

  Afvikling: ./udskriv
}

program udskriv;

var
 fil, {variabel til at lagre filens navn}
 txt : string[255]; {variabel til at lagre en tekstlinie}

 fptr : text; {variabel til at skabe adgang til en fil på disken}
 i : integer; {variabel som tælles op med 1 for hver ny linie}

begin
   {første linie}
   i := 1;
   {hent filnavnet fra kommandolinien: 0=programmet, 1=første
    parameter efter programmets navn}
   fil := paramstr(1);
   {skab forbindelse til filen på disken med det pågældende navn}
   assign (fptr,fil);
   {$i-}
   {slå automatisk fejlbehandling fra: skriv din egen rutine;
    fejlmeddelelser fra sidste I/O rutine kan læses i variablen IOResult}
   reset (fptr); {åben filen for læsning fra første linie}
   {$i+} {automatisk fejlbehandling slås til}
   {hvis resultatet af forsøget på at åbne filen resulterede i en
    fejl, vil variablen IOResult indeholde en værdi <> 0.}
   if IOResult <> 0 then
   begin
     {var der en fejl?}
     writeln('Filen findes ikke, programmet afsluttes.');
     exit; {stop programmet}
   end;
   writeln;
   writeln ('Indhold af filen: ',fil,'.');
   writeln;
   writeln ('linie tekst');
   writeln ('----- -----');
   {så længe der er linier i filen, forsætter vi med at læse}
   while not eof(fptr) do
   begin
      {læs en linie fra filen som fptr peger på,
       og læg resultat i variablen txt. Skift til næste linie}
      readln(fptr,txt);
      {skriv linienummeret - start i femte kolonne - og
       indholdet af variablen txt på skærmen}
      writeln(i:5,' ',txt);
      {tæl variablen i op med 1}
      inc(i);
   end;
end.
