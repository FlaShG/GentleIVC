#include "math.inc"

#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "shroom.inc"
#include "chessir.inc"

                                                      
#declare camera_look_at = <46 - 1.5, 11.8 * 0.7, 20.4>;                                           
#declare camera_offset_to_look_at = <-.5-1.5, 0.3, -3> * 0.3;    
                                                                       
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.005
   blur_samples 25
   right x*image_width / image_height
}

       
object
{
   shroom(34.1 * 0.7, 0, 1.2, shroomtexture, false) 
   translate <46, 0, 20.7>    
}

object
{
   ready_alice_with_hr(y * clock * 20)      
   scale 0.2
   translate <46, 7.6, 20.7>
}

object
{
   chessir_cat(clock * 2, clip(clock * 2, 0, 1))
   scale 0.5                                    
   rotate y*200
   translate <46, 7.6, 20.7> + <0.6, 0.5, 1.9>
}

light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
} 
   
//====================scene====================
                           
#include "shroomforest.inc" 
some_shrooms()
more_shrooms()
