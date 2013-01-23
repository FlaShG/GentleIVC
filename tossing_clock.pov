
#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "gentle.inc"
#include "pocket_watch.inc"

#include "math.inc"


#declare animation_length = 4; //480 frames, 4-fache Zeitlupe
                   
//#declare alice_position_z = 15.4 + clock*12;
                                                      
//#declare camera_look_at = <31, 0.5, 34>;
//#declare camera_offset_to_look_at = <-1, 0, -3>;
                                
#declare foo = clock*2 -1;
#declare clock_curve = (-(foo*foo)+1);
#declare clock_position = <31, 1+clock_curve*5.6, 33.5>;

#declare camera_look_at = clock_position;
                                                                       
camera
{
   location <31, 3+sqrt(sqrt(clock))*4.5, 33.45>
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.2 - clock_curve*0.19
   blur_samples 25
   right x*image_width / image_height
} 



#if(clock < 0.5)
   object
   {
      gentleman
      scale 0.3
               
      rotate y*180
      translate <31, 0, 34>
   }   
   
   object
   {
      ready_alice 
      scale 0.2   
      
      translate <31, 0, 32>    
   }
#end

object
{
   pocket_watch(1.6, 10, 4+floor(clock*animation_length))
   scale 0.08
                     
   rotate x*(40+clock*(360-80)) + z*(180+clock*720)
   translate clock_position
}    


light_source
{
   <-22,42,42>*2000 color rgb <0.757, 0.682, 0.612>*0.5 shadowless    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
} 
   
//====================scene====================
                           
#include "shroomforest.inc"

//some_shooms()
//some_looking_shrooms(<31, 0, 33.5>)
