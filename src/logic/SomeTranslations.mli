module SomeTranslations :
  sig
    type point = float * float
    type functionImage = point -> Graphics.color
    val xX : point -> float
    val yY : point -> float
    val distance : point -> point -> float
    val pointMul : point -> point -> float * float
    val pointPlus : point -> point -> float * float
    val pointMinus : point -> point -> float * float
    val to_polar : point -> float * float
    val to_carth : point -> float * float
    val circle : point -> float -> point -> Graphics.color
    val scale : functionImage -> float -> point -> Graphics.color
    val rotate : functionImage -> float -> point -> Graphics.color
    val translate : functionImage -> point -> point -> Graphics.color
    val loadDumpedImage : 'a array array -> point -> 'a
    val abs : float -> float
    val signum : float -> float
    val sq : float -> float
    val loadImageWithTrans :
      functionImage ->
      (float -> float) -> (float -> float) -> point -> Graphics.color
    val initialF :
      char -> Graphics.color array array -> int * int -> Graphics.color
    val from_rgb : Graphics.color -> int * int * int
    val inv_color : Graphics.color -> Graphics.color
    val getColor : Graphics.color array array -> int * int -> Graphics.color
    val random_pixels : Graphics.color array array -> point -> Graphics.color
    val invert_pixels :
      Graphics.color array array -> int * int -> Graphics.color
    val processColorMap : char -> Graphics.image -> Graphics.image
    val invert : Graphics.image -> Graphics.image
  end
