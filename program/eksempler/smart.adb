------------------------------------------------------------------------------
--
--  procedure Smart (body)
--
--  Ada er temmelig praktisk til at skrive programmer der skal lave flere ting
--  på en gang ("tasking"), og så kan det håndtere maskinnære ting som
--  bitmønstre på en abstrakt måde, så det er lettere at overskue hvad
--  programmet laver.
--
--  Programmet er afprøvet med GNAT (GNU Ada), men bør virke med alle
--  Ada-oversættere.
--
--  Oversættelse:
--    gnatmake udskriv -cargs -gnatv -gnati1 -gnatf -gnato
--
--  Afvikling:
--    ./udskriv [fil]+
--
------------------------------------------------------------------------------
--  Opdateringslog:
--
--  2000.01.09 (Jacob Sparre Andersen)
--    Skrevet.
--
------------------------------------------------------------------------------
--  Standardpakker:

with Ada.Text_IO;

------------------------------------------------------------------------------

procedure Smart is

   ---------------------------------------------------------------------------
   --  task Hils_På_Verden
   --
   --  En tråd der kører parallelt med resten af programmet.
   --  For at det ikke skal gå alt for hurtigt udskriver den kun et tegn i
   --  sekundet.

   task Hils_På_Verden;

   task body Hils_På_Verden is
      use Ada.Text_IO;
      Hilsen : constant String := "Hej Verden";
   begin
      for Indeks in Hilsen'Range loop
         Put (Hilsen (Indeks));
         delay 1.0;
      end loop;
      New_Line;
   end;

   ---------------------------------------------------------------------------
   --  Vi skal lige styre et lyssignal:
   --
   --  Vi har en 8-bit udgang:
   --    0-3 - ikke brugt
   --    4   - grøn
   --    5   - gul
   --    6   - rød
   --    7   - ikke brugt

   type Lyssignal_Lamper is
      record
         Rød, Gul, Grøn : Boolean;
      end record;

   for Lyssignal_Lamper use
      record
         Rød  at 0 range 6 .. 6;
         Gul  at 0 range 5 .. 5;
         Grøn at 0 range 4 .. 4;
      end record;

   for Lyssignal_Lamper'Size use 8;

   type Lyssignal is
      record
         Tændt : Lyssignal_Lamper;
         Tid   : Duration;
      end record;

   Tidsserie : array (1 .. 4) of Lyssignal :=
                 (1 => (Tændt => (Rød =>  True, Gul => False, Grøn => False),
                        Tid   => 3.0),
                  2 => (Tændt => (Rød =>  True, Gul =>  True, Grøn => False),
                        Tid   => 0.5),
                  3 => (Tændt => (Rød => False, Gul => False, Grøn =>  True),
                        Tid   => 3.0),
                  4 => (Tændt => (Rød => False, Gul =>  True, Grøn => False),
                        Tid   => 0.5));

   ---------------------------------------------------------------------------
   --  procedure Sæt_Port:
   --
   --  For at vi kan se hvad der sker, skriver vi bitmønsteret til skærmen i
   --  stedet for at sende det ud på en port.

   procedure Sæt_Port (Tændt : in     Lyssignal_Lamper) is

      type Byte is mod 2**8;
      for Byte'Size use 8;

      package Byte_Text_IO is new Ada.Text_IO.Modular_IO (Byte);

      use Ada.Text_IO;
      use Byte_Text_IO;

      Bitmønster : Byte;
      for Bitmønster'Address use Tændt'Address;

   begin
      New_Line;
      Put (Item  => " -- Sætter porten til ");
      Put (Item  => Bitmønster,
           Base  => 2,
           Width => 11);
      Put (Item  => " -- ");
      New_Line;
   end Sæt_Port;

   ---------------------------------------------------------------------------

begin
   for Indeks in Tidsserie'Range loop
      Sæt_Port (Tændt => Tidsserie (Indeks).Tændt);
      delay Tidsserie (Indeks).Tid;
   end loop;
end Smart;
