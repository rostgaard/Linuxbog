-- Eiffel
-- af Peter Stubbe <stubbe@bitnisse.dk>
-- $Id$
--
-- Progremmet er skrevet til SmallEiffel
-- http://www.loria.fr/SmallEiffel
--
-- Oversættelse:
--  compile udskriv -o udskriv
--
-- Afvikling:
--  ./udskriv [fil]+

class UDSKRIV

creation make

feature
  make is
    local
      fnr: INTEGER;
      fnavn: STRING;
      fil: STD_FILE_READ;
      lin: STRING;
      lnr: INTEGER;
      c: CHARACTER;
    do
      !!fnavn.make(30);
      !!lin.make(300);
      !!fil.make;

      from
        fnr:=1;
      until
        fnr>argument_count
      loop
        fnavn:=command_arguments.item(fnr);
        fil.connect_to(fnavn);
        if fil.is_connected then
          from
            lnr:=1;
          until
            fil.end_of_input
          loop
            fil.read_line_in(lin);
            io.put_integer(lnr);
            io.put_string("%T");
            io.put_string(lin);
            io.put_new_line;
            lin.clear;
            lnr:=lnr+1;
          end;
          fil.disconnect;
        else
          io.put_string("Filen ");
          io.put_string(fnavn);
          io.put_string(" kan ikke åbnes!%N");
        end;
        fnr:=fnr+1;
      end;
      from
      until
        c='Q'
      loop
        io.read_character;
        c:=io.last_character;
      end;
    end;
end
