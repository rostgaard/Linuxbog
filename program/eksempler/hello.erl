% Oversættelse:
% af Peter Stubbe <stubbe@bitnisse.dk>
% $Id$

%  erlc hello.erl
%
% Afvikling (let og elegant):
%  erl -noshell -s hello hej -s init stop

-module(hello).
-export([hej/0]).
hej() -> io:format('Hello, world!\n').
