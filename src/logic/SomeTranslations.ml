(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module SomeTranslations =
  struct
    
    type vector = float * float
      
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
      
      
    let getPoint (matrix) (v:vector) =
      match v with
        (a, b) -> matrix.(a).(b)
    
    let initialF matrix (v:vector) =
      let andOperation
      in
        match v with
          (a, b) -> matrix.(b).(a) + 10
 
    let processColorMap (img:Graphics.image) =
      let matrix = Graphics.dump_image img
      in
        let newmatrix = color array array
        in
          begin
            for i <- 1 to image.width do
              for j <- 1 to image.height do
                getPoint newmatrix (i, j) <- initialF matrix (i, j)  
              done
            done
          end;
          Graphics.make_image newmatrix
        
  end;;