(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

open Interface;;
open IterativeFunction;;
open IOOperations;;

let tortuga =
  Interface.main_loop IOOperations.openInitialGraphic IterativeFunction.load;;
;;