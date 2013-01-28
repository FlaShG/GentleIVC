

#include "table.inc"                                                                
#include "tea.inc"
#include "spoon.inc"
//#include "pocket_watch.inc"

#include "alice.inc"

#declare camera_look_at = <1.775,1.1,0>;                                           
#declare camera_offset_to_look_at = <-2.5 , 5 , .75> * .035 + .01*x*clock;


//#declare camera_look_at = <2,1,2>;
//#declare camera_offset_to_look_at = <-1 , 1 , 3> * .4; 
                                                                
camera
{
   location (camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.01  
   //blur_samples 25
   right x*image_width / image_height
}  
   
#declare light_vector = <-20, 30, -10>;   
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
   tea_table
   translate<0,0,0>
}    


object{
   //spoon_in_teacup_on_saucer 
   spoon_on_saucer
   scale .15
   translate <1.8, 1, 0>
}    

object
{
   teacup
   scale .12   
   rotate y*-80
   
   translate <-0.2, 0, 0>
   
   translate <2.5-0.45-(1*0.05), 1, 0>
}

#declare base_arm_l1 = y*-48 + z*-5;
#declare base_arm_l2 = y*-70 + z*-15;
#declare base_arm_r1 = y*-20 + z*-30;
#declare base_arm_r2 = y*-40 + z*170;

object
{
   //ready_alice
   alice(base_arm_l1, base_arm_l2,
         base_arm_r1, base_arm_r2)
   
   scale 0.3
   rotate y*-90
   translate x*2.3 + y*0.5
}

object
{
   chair
   rotate y*-90
   translate <2.3 , 0.0 , 0>
}