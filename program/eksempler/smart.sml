(*
  smart.sml
  af Peter Makholm <peter@makholm.net>
  $Id$

  Afvikling:
  1. Start mosml
  2. use "smart.sml"

  Ikke meget mere end Hej verden-stadiet, men viser nogle af de smarte
  dele af SML. Gennemgået i bogens afsnit om SML
*)

(* Type: ('a -> 'b) -> 'a list -> 'b list *) 
fun map f nil = nil 
  | map f (x::xs) = f(x) :: map f xs; 

(* Type: int list -> int list *)
val doublelist = map (fn x => 2 * x);

(* Type: ('a -> 'a) -> int -> 'a -> 'a *)
fun iterate f 0 x = x
  | iterate f i x = iterate f (i-1) (f x);

(* Lidt brug af ovenstående *)
val somelist = [1,2,3,4,5];
val anotherlist = iterate doublelist 5 somelist; 
