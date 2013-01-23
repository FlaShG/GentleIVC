
#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "gentle.inc"

#include "math.inc"

                   
//#declare alice_position_z = 15.4 + clock*12;
                                                      
//#declare camera_look_at = <31, 0.5, 34>;
//#declare camera_offset_to_look_at = <-1, 0, -3>;

#declare camera_look_at = <31, 1 - clock*0.5, 33.75>;
#declare camera_offset_to_look_at = <-0.2 - clock*0.8, 0, -1 - clock*2>;    
                                                                       
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
   ready_alice 
   scale 0.2   
   
   translate <31, 0, 32>    
}     


object
{
   looking_gentleman(x*10*clock)
   scale 0.3
            
   rotate y*180
   translate <31, 0, 34>
}


light_source
{
   <-22,42,42>*200 color rgb <0.757, 0.682, 0.612>*0.5 shadowless    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
} 
   
//====================scene====================
                           
#include "shroomforest.inc"

//some_shooms()
some_looking_shrooms(<31, 0, 32>)
