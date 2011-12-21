module type Translations =
  sig
    val invert : Graphics.image -> Graphics.image
    val processColorMap : char -> Graphics.image -> Graphics.image
  end
module IterativeFunction :
  functor (Tr : Translations) ->
    sig
      val compose : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b
      val id : 'a -> 'a
      val iterate : int -> ('a -> 'a) -> 'a -> 'a
      val load : char -> Graphics.image -> Graphics.image
    end
