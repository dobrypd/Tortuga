module Interface :
  sig
    exception End
    exception Save
    exception Next of char
    exception ShowHelp
    val skel :
      (unit -> 'a) ->
      (unit -> unit) ->
      (char -> unit) ->
      (int -> int -> unit) -> (exn -> 'b -> 'c -> unit) -> 'b -> 'c -> unit
    val init : unit -> unit
    val fend : unit -> unit
    val handle_char : char -> 'a
    val mouse : int -> int -> unit
    val exc :
      exn ->
      Graphics.image -> (char -> Graphics.image -> Graphics.image) -> unit
    val main_loop :
      Graphics.image -> (char -> Graphics.image -> Graphics.image) -> unit
  end
