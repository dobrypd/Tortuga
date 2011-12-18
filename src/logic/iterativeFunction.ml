(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module IterativeFunction =
struct
  let load functionType:f Graphics.image:img =
    f img
  ;;
  let compose f g x = 
    f (g x)
  ;;
  let id x = x;;
  let rec iterate n f =
    if n = 0 then id else compose (iterate (n-1) f) f
  ;;
end