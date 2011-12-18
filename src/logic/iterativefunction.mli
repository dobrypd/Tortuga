(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module IterativeFunction:
sig
  type functionType: Graphics.image -> Graphics.image 
  load : functionType -> Graphics.image -> Graphics.image
end