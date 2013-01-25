

#include "table.inc"                                                                
#include "tea.inc"
#include "spoon.inc"
#include "pocket_watch.inc"
#include "utah_teapot.inc"
#include "clock_skysphere.inc"

#include "alice.inc"

#declare camera_look_at = <1.45,1.6,0>+<-5,0,-10>;                                           
#declare camera_offset_to_look_at = <0.2 , -0.5 , -3> * .5;

#declare animation_length = 4;
                                                                
camera
{
   location (camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.05  
   blur_samples 25  
   angle 35
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
   pocket_watch(7, 20, 22+floor(clock*animation_length))
   scale 30
   translate y*-1.64
}


merge
{
   object
   {
      tea_table
      translate<0,0,0>
   }
   
   //teacups
   /*object{
      teacup_and_spoon_on_saucer
      scale 0.15
      translate y
   } */
   
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
   }
   
   #declare base_arm_l1 = y*-48 + z*-5;
   #declare base_arm_l2 = y*-70 + z*-15;
   #declare base_arm_r1 = y*-20 + z*-30;
   #declare base_arm_r2 = y*-40 + z*170;
   
   object
   {
      //ready_alice
      alice(base_arm_l1,
            base_arm_l2,
            base_arm_l1, base_arm_l2)
      
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
   
   object
   {
      utah_teapot
      scale .09  
      
      rotate y*49    
      rotate z*clip(clock*3, 0, 1)*-24
      
      translate <1.3,1,0.4>
      translate y*clip(clock*3, 0, 1)*0.11
   } 
   
   object
   {
      looking_gentleman(y*-20 + x*10)
      scale 0.3
             
             
      rotate y*180
      translate <1.3,0.8,1.2>
   }
   
   translate <-5,0,-10>
}




// mirrors

/*union
{
   box {
      2, <-2,-2,2.1>
      no_reflection  
      pigment{ color White }  
      finish { reflection 1 ambient 0.01 diffuse 0 }    
      rotate y*45
   }       
   box {
      2, <-2,-2,2.1>
      no_reflection  
      pigment{ color White }  
      finish { reflection 1 ambient 0.01 diffuse 0 }    
      rotate y*-45
   }    
   box {
      <-5,0,-5> <5,-1,5>
      no_reflection  
      pigment{ color White }  
      finish { reflection 0.1 ambient 0.05 diffuse 0 }    
   }
   
   translate z*.5
}*/ 