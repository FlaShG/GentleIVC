
#include "alice.inc"

#include "math.inc"

                   
//#declare alice_position_z = 15.4 + clock*12;
#declare alice_position_z = 15.4 + clock*16;
                                                      
#declare camera_look_at = <31, 0.5, alice_position_z>;                                           
#declare camera_offset_to_look_at = <0, 0.2, 2>;    
                                                                       
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
   translate <31, 0, alice_position_z>    
}