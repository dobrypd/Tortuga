(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module Interface =
struct

  exception End
  exception Save
  exception Next of char
  exception ShowHelp

  let skel f_init f_end f_key f_mouse f_except img f =
    f_init ();
    try
      while true do
        try
          let s = Graphics.wait_next_event
            [Graphics.Button_down; Graphics.Key_pressed]
          in 
            if s.Graphics.keypressed then 
              f_key s.Graphics.key
            else 
              if s.Graphics.button then 
                f_mouse s.Graphics.mouse_x s.Graphics.mouse_y
        with
          End -> raise End|
          Next c -> f_except (Next c) img f|
          e -> f_except e img f
      done
    with
      End -> f_end()

  let init () =
    Graphics.clear_graph();
    Graphics.moveto 0 0

  let fend () =
    Graphics.clear_graph()

  let handle_char c =
    match c with
      's' -> raise Save |
      'q' -> raise End |
      'h' -> raise ShowHelp |
      _ -> raise (Next c)

  let mouse x y =
    Graphics.moveto x y

  let exc e img f= 
    match e with
      Save ->
        Graphics.blit_image img 0 0;
        Graphics.draw_image img 0 0|
      Next c->
        let newi = f c img
        in
          Graphics.draw_image newi 0 0;
          Graphics.blit_image img 0 0 |
      ShowHelp ->
        Graphics.draw_string "q - quit, h - help : other keys - next iteration" |
      _ ->
        Graphics.draw_image img 0 0

  let main_loop (img:Graphics.image) (f:(char -> Graphics.image -> Graphics.image)) =
      skel init fend handle_char mouse exc img f

end;;