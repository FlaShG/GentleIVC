#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "shroom.inc"

                                                      
#declare camera_look_at = <46 - clock*.5, 11.8 * 0.7, 20.4>;                                           
#declare camera_offset_to_look_at = <-.5-clock*1.5, 0.3, -3> * 0.3;    
                                                                       
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.2
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
   ready_alice      
   scale 0.2
   translate <46, 7.6, 20.7>
}

/*light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}*/ 
   
//====================scene====================
                           
#include "shroomforest.inc"
more_shrooms()
