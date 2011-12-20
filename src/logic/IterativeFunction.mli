(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski

   co jeszcze:
   przeksztalcenie zadane przez macierz
   obroty, translacje i skalowanei
   nieliniowe przeksztalcenia, plaszczyzny: rybie oko inwersja.
*)

module type Translations =
  sig
    type vector
    val invert : Graphics.image -> Graphics.image
    val processColorMap : Graphics.image -> Graphics.image
  end
module IterativeFunction :
  functor (Tr : Translations) ->
    sig
      val compose : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b
      val id : 'a -> 'a
      val iterate : int -> ('a -> 'a) -> 'a -> 'a
      val load : unit -> Graphics.image -> Graphics.image
    end
