
#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "shroom.inc"

                                                      
#declare camera_look_at = <60, 0, 10.7>;                                           
#declare camera_offset_to_look_at = <0, 62-(clock*30), 0>;
      
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point <60, 40-(clock*10), 10.7>
   aperture 0.2 
   blur_samples 25
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
   shroom(100, 0, 1.2, shroomtexture, false) 
   translate <60, 0, 10.7>    
}

/*light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}*/ 
   
//====================scene====================
                           
#include "shroomforest.inc"