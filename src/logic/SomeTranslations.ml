(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module SomeTranslations =
  struct
    
    type vector = float -> float
      
    let invert (img:Graphics.image) =
      let from_rgb = (fun (c : Graphics.color) ->
        let r = c / 65536 and g = c / 256 mod 256 and b = c mod 256
        in 
          (r,g,b)) 
      in
      let inv_color = (fun (c : Graphics.color) ->
        let (r,g,b) = from_rgb c
        in
          Graphics.rgb (255-r) (255-g) (255-b))
      in
      let inv_vec = Array.map (fun c -> inv_color c) 
      in
        let inv_mat = Array.map inv_vec 
        in
          let inverted_matrix = inv_mat (Graphics.dump_image img) 
          in
            Graphics.make_image inverted_matrix
      
    let rotate (d:float) (img:Graphics.image) =
      img (*TODO*)
  
    let translation (v:vector) (img:Graphics.image) =
      img (*TODO*)
  end;;