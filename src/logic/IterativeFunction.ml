(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module type Translations = 
  sig
    val invert : Graphics.image -> Graphics.image
    val processColorMap : char -> Graphics.image -> Graphics.image
  end;;

module IterativeFunction = functor (Tr: Translations) ->
  struct
      
    let compose f g x = 
      f (g x)
      
    let id x = x
      
    let rec iterate n f =
      if n = 0 then id else compose (iterate (n-1) f) f
        
    let load (c:char) =
      Tr.processColorMap c
  end;;
