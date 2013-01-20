#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "shroom.inc"


#declare camera_look_at = <46, 11, 20.4>; 
#declare camera_offset_to_look_at = <-2,1,2>;

camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   blur_samples 25
   right x*image_width / image_height
}

  
object{ready_alice scale .2 translate camera_look_at}  

object
{
   shroom(35, 0, 1.2, shroomtexture, false) 
   translate <46, 0, 20.7>    
}


#include "shroomforest.inc" 

more_shrooms()

