(*
   Tortuga project
   (c) 2011 Piotr Dobrowolski
*)

module SomeTranslations = 
  struct
    type point = float * float
    type functionImage = point -> Graphics.color
      
    let xX (c:point) =
      match c with
        (a, _) -> a
    let yY (c:point) =
      match c with
        (_, b) -> b
    

    let distance (p1:point) (p2:point) =
      let 
        x = xX(p2) -. xX(p1)
      and
        y = yY(p2) -. yY(p1)
      in
        let sqr_dist = x*.x +. y*.y
        in
          if (sqr_dist <= 0.0) then
            0.0
          else
            sqrt(sqr_dist)
      
    let pointMul (p1:point) (p2:point) =
      (xX(p1)*.xX(p2) -. yY(p1)*.yY(p2), xX(p1)*.yY(p2) +. yY(p2)*.xX(p1))
    
    let pointPlus (p1:point) (p2:point) =
      (xX(p1) +. xX(p2), yY(p1) +. yY(p2))
      
    let pointMinus (p1:point) (p2:point) =
      (xX(p1) -. xX(p2), yY(p1) -. yY(p2))
      
    let to_polar (p:point) =
      let
        (p00:point) = (0.0, 0.0)
      and
        m_PI = 4.0 *. atan 1.0
      in
        let
          r = distance p00 p
        in
          if ((xX(p) > 0.0) && (yY(p) >= 0.0)) then 
            (r, atan(yY(p) /. xX(p)))
          else 
          if ((xX(p) > 0.0) && (yY(p) < 0.0)) then
            (r, atan(yY(p) /. xX(p)) +. 2.0 *. m_PI)
          else 
          if (xX(p) < 0.0) then
            (r, atan(yY(p) /. xX(p)) +. m_PI)
          else 
          if ((xX(p) == 0.0) && (yY(p) > 0.0)) then
            (r, m_PI /. 2.0)
          else 
          if ((xX(p) == 0.0) && (yY(p) < 0.0)) then
            (r, m_PI *. 1.5)
          else
            (r, 0.0)
    
    let to_carth (p:point) =
      (xX(p) *. cos(yY(p)), xX(p) *. sin(yY(p)))
    
    let circle (p:point) (r:float) =
      let circle_color (p:point) (r:float) (c_in:Graphics.color) (c_out:Graphics.color) (x:point) =
        if (distance x p > r)
        then
          c_out
        else
          c_in
      in
        circle_color p r Graphics.yellow Graphics.green
      
    let scale (i:functionImage) (s:float) (x:point)=
      let scale_h (i:functionImage) (s:float) (x:point) =
        let scale_radius (s:float) (x:point) =
          (xX(x)*.s, yY(x))
        in
          i (to_carth (scale_radius (1.0/.s) (to_polar x) ) )
      in
        scale_h i s x
      
    let from_rgb = (fun (c : Graphics.color) ->
      let r = c / 65536 and g = c / 256 mod 256 and b = c mod 256
      in 
        (r,g,b))
    
    let inv_color = (fun (c : Graphics.color) ->
      let (r,g,b) = from_rgb c
      in
        Graphics.rgb (255-r) (255-g) (255-b))     
      
    let getColor (matrix:Graphics.color array array) (v:(int*int)) =
      match v with
        (a, b) -> matrix.(a).(b)
        
    let random_pixels (matrix:Graphics.color array array) (v:point) =
      Graphics.rgb (Random.int 256) (Random.int 256) (Random.int 256)
      
    let invert_pixels (matrix:Graphics.color array array) (v:(int*int)) =
      inv_color(getColor matrix v)
      
      
      
    (*MAIN funciton*)
    
    let initialF matrix (v:(int*int)) =
      match v with
        (a, b) -> let new_a = (float_of_int a) -. 400.0
                  and new_b = (float_of_int b) -. 300.0
                  in
          (scale ( circle (0.0, 0.0) 10.0 ) 10.0) (new_a, new_b)
      
      
    (*implementation of imperative draving functions*)
 
    let processColorMap (img:Graphics.image) =
      let 
        matrix = Graphics.dump_image img
      and
        width = Graphics.size_x()
      and
        height = Graphics.size_y()
      in
        let
          newmatrix = Array.make_matrix height width 0
        in
          begin
            for i = 0 to height-1 do
              for j = 0 to width-1 do
                newmatrix.(i).(j) <- initialF matrix (i, j)  
              done
            done
          end;
          Graphics.make_image newmatrix
   
     let invert (img:Graphics.image) =
        let inv_vec = Array.map (fun c -> inv_color c) 
        in
          let inv_mat = Array.map inv_vec 
          in
            let inverted_matrix = inv_mat (Graphics.dump_image img) 
            in
               Graphics.make_image inverted_matrix
        
  end;;