-- Programmet er skrevet til Gnat
-- af Peter Stubbe <stubbe@bitnisse.dk>
-- $Id$

-- Oversættelse:
--  gnatmake hello.adb
--
-- Afvikling:
--  ./hello

with Text_IO; use Text_Io;
procedure Hello is
begin
  Put_Line("Hello, world!");
end;
