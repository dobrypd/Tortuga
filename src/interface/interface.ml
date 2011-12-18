(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module Interface =
struct
  let main_loop =
    Graphics.open_graph(" 800x600");
    let img : Graphics.image = Graphics.create_image 100 100 
    in
      Graphics.clear_graph ();
      while true do
        Graphics.moveto 0 0;
        Graphics.draw_string "dupa!";
        Graphics.blit_image img 0 0;
        Graphics.draw_image img 200 200;
      done;
      Graphics.close_graph ()
  ;;
end