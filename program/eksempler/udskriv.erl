% af Peter Stubbe <stubbe@bitnisse.dk>
% $Id$

% Oversættelse:
%  erlc udskriv.erl
%
% Afvikling (let og elegant):
%  erl -noshell -s udskriv skriv -s init stop -- [fil]+

-module(udskriv).
-export([skriv/0]).

skrivdet(N, eof) -> 0;

skrivdet(N, S) ->
  io:format('~w\t~s', [N, S]),
  1.

skrivlin(N, FH) ->
  case skrivdet(N, io:get_line(FH, '')) of
    0 -> 0;
    1 -> skrivlin(N+1, FH)
  end.

skrivfil([]) -> 0;
skrivfil([Fnavn|L]) ->
  Filres = file:open(Fnavn, read),
  {Ok, Fil}=Filres,
  if
    Ok == ok -> skrivlin(1, Fil),
                file:close(Fil);
    Ok == error -> io:format('Filen ~s kan ikke åbnes!\n', [Fnavn])
  end,
  skrivfil(L).

slut("Q") -> 0;
slut(C) ->
  slut(io:get_chars('', 1)).

skriv() ->
  skrivfil(init:get_plain_arguments()),
  slut(io:get_chars('',1)).
