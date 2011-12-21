(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

(* TODO:
 copy from students to local repository!!!
 *)

open Interface;;
open IterativeFunction;;
open SomeTranslations;;

module FinalFunctions = IterativeFunction (SomeTranslations);;

Graphics.open_graph(" 800x600");
let
  img = Graphics.create_image 800 600;
in
  Interface.main_loop img (FinalFunctions.load);;
