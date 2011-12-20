(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module type Translations = 
  sig
    type vector
    val invert : Graphics.image -> Graphics.image
    val processColorMap : Graphics.image -> Graphics.image
  end;;

module IterativeFunction = functor (Tr: Translations) ->
  struct
      
    let compose f g x = 
      f (g x)
      
    let id x = x
      
    let rec iterate n f =
      if n = 0 then id else compose (iterate (n-1) f) f
        
    let load () =
      Tr.processColorMap
  end;;
