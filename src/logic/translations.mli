(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module type TRANSLATIONS = 
sig
  type ttype = Graphics.image -> Graphics.image
  type vector = double -> double
  val invert : ttype
  val rotate : double -> ttype
  val translation : vector -> ttype
end;;