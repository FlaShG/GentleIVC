
#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "shroom.inc"

                                                      
#declare camera_look_at = <58, 10, 10.7>;                                           
//#declare camera_offset_to_look_at = <0, 62-(clock*30), 0>;
//#declare camera_offset_to_look_at = <0, 5, 0>;
#declare camera_offset_to_look_at = <0, 52-(clock*50), 0>;
      
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point <58, 28-(clock*10), 10.7>
   aperture 0.2 
   blur_samples 25
   right x*image_width / image_height
}     

       
object
{
   shroom(35, 0, 1.2, shroomtexture, false) 
   translate <58, 0, 10.7>    
}

/*light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}*/ 
   
//====================scene====================
                           
#include "shroomforest.inc"