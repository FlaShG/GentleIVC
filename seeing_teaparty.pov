
#include "alice.inc"
#include "pocket_watch.inc"

#include "table.inc"                                                                
#include "tea.inc"
#include "spoon.inc"
#include "utah_teapot.inc"

#include "clock_skysphere.inc"


#include "math.inc" 
 
 
#declare myclock = clock * 2;
#declare myclock_clipped = clip(myclock, 0, 1);   

#declare animation_length = 3;
                   
//#declare alice_position_z = 15.4 + clock*12;
#declare alice_position_z = -18 + myclock*2;
                                                      
#declare camera_look_at = <-5,1,-9-(clock*1)>;                                           
#declare camera_offset_to_look_at = <-10, 0, 10>*1;    
 
                                                                       
camera
{
   location <-5,1,-9> + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.2
   blur_samples 25
   right x*image_width / image_height
   angle (1-(clock*0.5))*60
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
   pocket_watch(1.7, 20, 26+floor(clock*animation_length))
   scale 30
   translate y*-1.64
}
 


#declare schritte = 2*pi;         

#declare sinus = sin(myclock * schritte);
#declare sinus1 = (sinus+1) / 2;

#declare cosinus = cos(myclock * schritte);
#declare cosinus1 = (cosinus+1) / 2;
 
       
object
{
   //alice(-z*50, y*-(100-10*sinus1) -x*sinus1*10,
   //      -z*50, y*-(100-10*sinus1) -x*sinus1*10)
         
   alice_with_hr(-z*50 + y*-(sinus*10), y*-110,
                 -z*50 + y*-(-sinus*10), y*-110,
                 //head rotation
                 y * clip(cos(myclock*pi*1.2) * 1.3, -1, 1) * 40
                 + x * -10 * myclock_clipped)  
         
   //ready_alice 
   
   scale 0.2
   scale y * (1+sin(myclock * schritte * 2) * 0.02)
   scale z * (1+cos(myclock * schritte * 2) * 0.02)
   rotate y*120
   translate <alice_position_z, 0, 5+alice_position_z*0.3>    
}

/*object
{
   //alice(-z*50, y*-(100-10*sinus1) -x*sinus1*10,
   //      -z*50, y*-(100-10*sinus1) -x*sinus1*10)
         
   alice_with_hr(-z*50 + y*-(sinus*10), y*-110,
                 -z*50 + y*-(-sinus*10), y*-110,
                 //head rotation
                 y * clip(cos(myclock*pi*1.2) * 1.3, -1, 1) * 40
                 + x * -10 * myclock_clipped)  
         
   //ready_alice 
   
   scale 0.2
   scale y * (1+sin(myclock * schritte * 2) * 0.02)
   scale z * (1+cos(myclock * schritte * 2) * 0.02)
   rotate y*120
   translate <-18, 0, 5>    
}*/  




merge
{
   object
   {
      tea_table
      translate<0,0,0>
   }
   
   //teacups
   object
   {
      teacup_and_spoon_on_saucer
      scale 0.15
      rotate y*94
      translate y + x*-1.6
   }
   
   object
   {
      spoon_on_saucer
      scale 0.15
      rotate y*94
      translate y + x*1.6
   }
   object
   {
      empty_teacup
      scale 0.15
      rotate y*94
      translate y + x*1.6
      translate y*0.06
   }
   
   object
   {
      gentleman
      
      scale 0.3
      
      rotate y*90 
      
      translate<-2.4, 0.5, 0>
   }
   
   object
   {
      chair
      rotate y*90
      translate <-2.4 , 0.0 , 0>
   }
   
   object
   {
      utah_teapot
      scale .09  
      
      rotate y*49
      translate <-0.4,1,0.4>
   } 
   
   translate <-5,0,-10>
}