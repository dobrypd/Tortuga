(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

open Interface;;
open IterativeFunction;;
open SomeTranslations;;

module FinalFunctions = IterativeFunction (SomeTranslations);;

let 
  img = Graphics.create_image 100 100
in
  Interface.main_loop img (FinalFunctions.load ())
;;