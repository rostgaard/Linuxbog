-- Eiffel
-- af Peter Stubbe <stubbe@bitnisse.dk>
-- $Id$
--
-- Progremmet er skrevet til SmallEiffel
-- http://www.loria.fr/SmallEiffel
--
-- Oversættelse:
--  compile hello -o hello
--
-- Afvikling:
--  ./hello

class HELLO

creation make

feature
  make is
    do
      io.put_string("Hello, world!%N");
    end;
end
