(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module Interface =
struct

  exception End
  exception ContinousSwitch
  exception Next
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
          End -> raise End |
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
      '\n' -> raise ContinousSwitch |
      ' ' -> raise Next |
      'q' -> raise End |
      'h' -> raise ShowHelp |
      _ -> raise ShowHelp

  let mouse x y =
    Graphics.moveto x y

  let exc e img f= 
    match e with
      ContinousSwitch ->
        Graphics.draw_image img 0 0 |
      Next ->
        let newi = f img
        in
          Graphics.draw_image newi 0 0;
          Graphics.blit_image img 0 0 |
      ShowHelp -> 
        Graphics.moveto 50 50;
        Graphics.draw_string "Tu bedzie pomoc" |
      _ ->
        Graphics.draw_image img 0 0

  let main_loop (img:Graphics.image) (f:(Graphics.image -> Graphics.image)) =
      Graphics.open_graph(" 800x600");
      skel init fend handle_char mouse exc img f

end;;