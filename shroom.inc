#include "gentle.inc"

#declare shroomtexture =
texture
{
   pigment
   {
      crackle scale 0.8
      color_map
      {
         [0.00 color Red]
         [0.2 color Red]
         [0.25 color rgb 0.9]
         [0.60 color White]
      }
      scale 0.2
   }                               
   
   finish
   {
      diffuse 2
      //reflection 0.042
   }
}

#macro shroom(shroom_height, shroom_shear, shroom_top_radius, shroom_top_texture, shroom_gentle)   
   merge
   {
       blob
       {
          threshold 0.3
          sphere
          {
             0 1 1
          }     
          cylinder
          {
             0 y*((shroom_height)-0.5) 0.7 1
             translate y*0.8
          } 
          sphere
          {
             (shroom_height)*y 0.8 1
          }   
          
          texture
          {
             pigment { color White }    
             
             normal { agate 0.1 agate_turb 1 scale 1 }
          }                         
          
          
                                                      
          matrix<1  , 0, 0, //  matrix-shear_y_to_x 
        shroom_shear, 1, 0,
                 0  , 0, 1,
                 0  , 0, 0>                                                      
                                                      
          scale 0.3
       } 
       
       merge
       { 
          merge
          {
             sor
             {
                6
                <1.0,0.0>
                <1.0,0.2>
                <0.8,0.4> 
                <0.3,0.7>
                <0.02,0.8>
                <0.0,0.8>
                sturm
             
                translate y*-0.2 
             }
             
             difference
             { 
                torus
                {
                   1-0.15 0.15
                }
              
                box
                {
                   <2,0,2>
                   <-2,1,-2>
                }
             }
               
            scale 0.8 * <(shroom_top_radius),1,(shroom_top_radius)>  
         } 
          
       #if((shroom_gentle))
          object
          {
             stache
             scale 0.4
             translate z*0.8*(shroom_top_radius)
          }
       #end
       
          translate y*((shroom_height) * 0.3) + (x * (shroom_shear) * ((shroom_height) / 3.3))
          
          texture
          {
             shroom_top_texture
          }
       }
       

   }              
#end  