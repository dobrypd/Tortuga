(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module SomeTranslations :
  sig
    type vector = float -> float
    val invert : Graphics.image -> Graphics.image
    val rotate : float -> Graphics.image -> Graphics.image
    val translation : vector -> Graphics.image -> Graphics.image
  end
