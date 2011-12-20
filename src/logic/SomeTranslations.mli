module SomeTranslations :
  sig
    type vector = float * float
    type point = int * int
    val invert : Graphics.image -> Graphics.image
    val getPoint : Graphics.color array array -> point -> Graphics.color
    val initialF : Graphics.color array array -> point -> int
    val processColorMap : Graphics.image -> Graphics.image
  end
