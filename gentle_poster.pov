// Sir Povington-Renderworth  
          
          
#include "rand.inc"
                     
#declare my_clock = 0.7;  
#declare my_initial_clock = 0;
#declare my_clock_delta = 0.2;
#declare my_final_clock = 1;
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random);                   
                     
#include "colors.inc"
#include "skies.inc"  
#include "stars.inc"  
#include "math.inc" 
#include "gentle.inc"
#include "alice.inc"
#include "shroom.inc"

                                                      
#declare camera_look_at = <5,4.5,5>;                                           
#declare camera_offset_to_look_at = <-12.5, 5, -12> * 0.5;
#declare alice_position = <5,4.5,5> + <-3.7,2.85,-2.9>;
#declare sir_position = <5,4.5,5> + <-4.1,2.65,-2.6>;
      
camera
{
   location (1/*shouldbeclock*/+0.2)*(camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point alice_position
   aperture 0.2 
   /*blur_samples 50*/
   right x*image_width / image_height
}     

/*sphere
{
   camera_look_at
   0.2              
   texture
   {
      pigment
      {
         color Yellow
      }
      finish
      {
         ambient 1
      } 
   }
}*/

object
{
   alice       
   scale 0.2            
   rotate y*180
   translate alice_position
   
}

object
{
   gentleman
   scale 0.2
   rotate y*220
   translate sir_position
}
   
//====================scene====================
//floor

box
{
   <-200,0,-200>
   <200,-5,200>
 texture {
  pigment {
     granite
     turbulence 6
     color_map {
       [0.000 color rgb <0.5, 0.5, 0.2>]
       [0.25 color rgb <0.7, 1, 0.2>]
       [0.5 color rgb <1, 0.4, 0.2>]
       [0.75 color rgb <.5, 0.9, 0.2>]
       [1 color rgb <0.3, 0.9, 0.2>]
     }
     scale 5
   }
   finish{specular .25 }
           normal{
             average normal_map{
                 [0.0 bumps 150 scale 30]
                 [0.2 dents 50 scale 12.5 turbulence .3]
                 [0.6 bozo 20 rotate x*90
 rotate y*45 scale 30 ]
                 [1.0 wrinkles 25 scale 5 scallop_wave rotate z*30]
                 }//end of normal map
                 rotate z*15 turbulence .4
               }//end of normal dec
 }
} 

/* 
object
{   
   piped_gentleman 
   rotate <0,210,0>
   translate <0,0,0*4>
}
object
{   
   piped_gentleman 
   rotate <0,210,0>
   translate <0,0,1*4>
}
object
{   
   piped_gentleman 
   rotate <0,250,0>
   translate <0,0,2*4>
}
object
{   
   piped_gentleman 
   rotate <0,190,0>
   translate <-1.5,0,3*4>
}
object
{   
   piped_gentleman 
   rotate <0,190,0>
   translate <5,0,6>
}  
*/ 
                           
#include "shroomforest.inc"
