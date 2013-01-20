
#include "alice.inc"
#include "pocket_watch.inc"

#include "math.inc"

                   
//#declare alice_position_z = 15.4 + clock*12;
#declare alice_position_z = -20 + clock*2;
                                                      
#declare camera_look_at = <5, 0.2 + clock*0.2, alice_position_z>;                                           
#declare camera_offset_to_look_at = <1 - clock * 2, 1 + clock, 4 + clock>*0.3;    
                                                                       
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.2
   //blur_samples 25
   right x*image_width / image_height
}  

#declare light_vector = <-8, 30, 10>;   
light_source
{
   light_vector*2000 0.4
} 
light_source
{
   light_vector*-2000 0.07 shadowless
}


object
{
   pocket_watch(9, 15, 45)
   scale 30
   translate y*-1.64
}
 


#declare schritte = 2*pi;         

#declare sinus = sin(clock * schritte);
#declare sinus1 = (sinus+1) / 2;

#declare cosinus = cos(clock * schritte);
#declare cosinus1 = (cosinus+1) / 2;
 
       
object
{
   //alice(-z*50, y*-(100-10*sinus1) -x*sinus1*10,
   //      -z*50, y*-(100-10*sinus1) -x*sinus1*10)
         
   alice_with_hr(-z*50 + y*-(sinus*10), y*-110,
                 -z*50 + y*-(-sinus*10), y*-110,
                 //head rotation
                 y * clip(cos(clock*pi*1.2) * 1.3, -1, 1) * 40
                 + x * -10 * clock)  
         
   //ready_alice 
   
   scale 0.2
   scale y * (1+sin(clock * schritte * 2) * 0.02)
   scale z * (1+cos(clock * schritte * 2) * 0.02)
   translate <5, 0, alice_position_z>    
}