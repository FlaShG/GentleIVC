// Sir Povington-Renderworth  
          
          
#include "rand.inc"
                     
/*#declare my_clock = 0.7;  
#declare my_initial_clock = 0;
#declare my_clock_delta = 0.2;
#declare my_final_clock = 1;     */
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
 
#include "gentle.inc"
#include "alice.inc"
#include "shroomforest.inc"

                                                      
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
                           
#include "shroomforest.inc"
