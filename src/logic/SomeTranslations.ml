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
    
    let rotate (i:functionImage) (q:float) (x:point) =
      i (to_carth (pointPlus (to_polar x) (0.0, -.q) ) )
      
    let translate (i:functionImage) (v:point) (x:point) =
      i (pointMinus x v)
      
    
    let loadDumpedImage matrix (x:point) =
      match x with
        (afloat, bfloat) -> 
          let 
            a = int_of_float afloat
          and
            b = int_of_float bfloat
          in
            let
              a_in_borders = min (max (a + 300) 0) (600-1)
            and
              b_in_borders = min (max (b + 400) 0) (800-1)
            in
              matrix.(a_in_borders).(b_in_borders)
        
    (*let sq (a:float) =
      (log (a+.300.0)) *. 2.0*)
        
    let abs (a:float) =
      if a >= 0.0 then
        a
      else
        -.a
    
    let signum (a:float) =
      if a >= 0.0 then
        1.0
      else
        -.1.0
    
    let sq (a:float) =
      (signum a) *. log (abs (a *. 100.0))
    
    let fish (a:float) =
      (-.(a +. 15.0)*.(a +. 15.0)) -. 10.0
    
    let loadImageWithTrans (i:functionImage) (fx:(float->float)) (fy:(float->float)) (x:point) =
      match x with
        (afloat, bfloat) -> 
          let 
            a = (fx afloat)
          and
            b = (fy bfloat)
          in
            i (a, b)
      
    (* end of graphics functions implementation*)    
      
      
    (*MAIN funciton*)
        (* c -- is option *)
    let initialF (c:char) matrix (v:(int*int)) =
      match v with
        (a, b) -> let new_a = (float_of_int a) -. 300.0
                  and new_b = (float_of_int b) -. 400.0
                  in
        match c with (*without s, q and h*)
          'a' -> scale (loadDumpedImage matrix) 2.0 (new_a, new_b)|
          'b' -> circle (1.1, 2.2) 10.0 (new_a, new_b)|
          'c' -> scale (circle (1.1, 4.4) 10.0) (8.7) (new_a, new_b)|
          'd' -> rotate (loadDumpedImage matrix) 0.1 (new_a, new_b)|
          'e' -> translate (loadDumpedImage matrix) (1.1, 1.1) (new_a, new_b)|
          'f' -> circle (0.0, 0.0) 100.0 (new_a, new_b)|
          'g' -> loadImageWithTrans (circle (0.0, 0.0) 12.0 ) sq sq (new_a, new_b)|
          'i' -> loadImageWithTrans (loadDumpedImage matrix) fish fish (new_a, new_b)|
          _   -> loadDumpedImage matrix (new_a, new_b)
          
    (***************)
      
      
    (*implementation of imperative draving functions*)
        
    (*operations on matrix, pixels or color*)      
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
      
      
    (*functor implementation*)
 
    let processColorMap (c:char) (img:Graphics.image) =
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
                newmatrix.(i).(j) <- initialF c matrix (i, j)  
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