with Ada.Text_IO, Ada.Integer_Text_IO;

procedure Bottles is
   use Ada.Text_IO, Ada.Integer_Text_IO;

   Count : Natural := 99;
begin
   loop
      Put (Count, Width => 0); Put_Line (" bottles of beer on the wall,");
      Put (Count, Width => 0); Put_Line (" bottles of beer.");
      Put_Line ("Take one down and pass it around.");
      Count := Count - 1;
      exit when Count = 0;
      Put (Count, Width => 0); Put_Line (" bottles of beer on the wall.");
      New_Line;
   end loop;
   Put_Line ("No bottles of beer on the wall!");
   New_Line;
end Bottles;
