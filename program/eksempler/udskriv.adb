-- af Peter Stubbe <stubbe@bitnisse.dk>
-- $Id$

-- Programmet er skrevet til Gnat
-- Oversættelse:
--  gnatmake udskriv.adb
--
-- Afvikling:
--  ./udskriv [fil]+

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;

procedure Udskriv is
package IntegerIO is new Ada.Text_IO.Integer_Io(Integer);
use IntegerIO;

  function Findesfil(Navn: String) return Boolean is
  Fil: Ada.Text_Io.File_Type;
  begin
    Open(Fil, In_File, Navn);
    Close(Fil);
    return True;

  exception
    when Name_Error => return False;
  end;

Lnr: Integer;
Fil: Ada.Text_Io.File_Type;
I: Integer;
C:Character;
begin
  for I in 1 .. Ada.Command_Line.Argument_Count loop
    Lnr:=1;
    if not Findesfil(Ada.Command_Line.Argument(I)) then
      Put("Filen ");
      Put(Ada.Command_Line.Argument(I));
      Put_Line(" findes ikke!");
    else
      Open(Fil,In_file,Ada.Command_Line.Argument(I));
      while not End_Of_File(Fil) loop
        Put(Lnr, 1);
        Set_Col(10);
        while not End_Of_Line(Fil) loop
          Get(Fil, c);
          Put(c);
        end loop;
        Put_Line("");
        Skip_Line(Fil);
        Lnr:=Lnr+1;
      end loop;
      Close(Fil);
    end if;
  end loop;
  C:=' ';
  while C /= 'Q' loop
    Get(C);
  end loop;
end;
