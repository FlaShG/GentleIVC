#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "shroom.inc"

                                                      
#declare camera_look_at = <46, 11, 20.4>;                                           
#declare camera_offset_to_look_at = <0, 52-(clock*50), -20+(clock*19)>;    
                                                                       
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   //focal_point <58, 28-(clock*10), 20.7>
   focal_point <46, 11, 20.7>
   aperture 10 - (clock*9) 
   //aperture 1
   blur_samples 25
   right x*image_width / image_height
}

       
object
{
   shroom(35, 0, 1.2, shroomtexture, false) 
   translate <46, 0, 20.7>    
}

/*light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}*/ 
   
//====================scene====================
                           
#include "shroomforest.inc"
