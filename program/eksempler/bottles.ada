with Ada.Text_IO, Ada.Integer_Text_IO;

procedure Bottles is
   procedure Put_Bottles (Count : in Natural) is
      use Ada.Text_IO, Ada.Integer_Text_IO;
   begin
      case Count is
         when 0 =>
            Put ("No bottles");
         when 1 =>
            Put ("1 bottle");
         when others =>
            Put (Count, Width => 0); Put (" bottles");
      end case;
   end Put_Bottles;

   use Ada.Text_IO;
begin
   for Count in reverse 1 .. 99 loop
      Put_Bottles (Count); Put_Line (" of beer on the wall,");
      Put_Bottles (Count); Put_Line (" of beer.");
      Put_Line ("Take one down and pass it around.");
      Put_Bottles (Count - 1); Put_Line (" of beer on the wall.");
      New_Line;
   end loop;
end Bottles;
