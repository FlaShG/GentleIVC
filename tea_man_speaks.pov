

#include "table.inc"                                                                
#include "tea.inc"
#include "spoon.inc"
#include "pocket_watch.inc"
#include "utah_teapot.inc"
#include "clock_skysphere.inc"

#include "gentle.inc"

#declare camera_look_at = <-2,1.4,0>+<-5,0,-10>;                                           
#declare camera_offset_to_look_at = <3 , 0.3 , -0.5> * .4;
  
//#declare camera_offset_to_look_at = <-7 , 1 , -1> * .4;

//#declare camera_look_at = <2,1.2,0>;
//#declare camera_offset_to_look_at = <10 , 1 , 10> * .1;

                                                                
camera
{
   location (camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.05  
   blur_samples 25
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
   pocket_watch(1.7, 20, 48)
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
   object{
      teacup_and_spoon_on_saucer
      scale 0.15
      rotate y*94
      translate y + x*-1.6
   }
   
   object
   {
      talking_gentleman(clip( sin(clock * pi * 8) * 12 , -10, 10 ))
      
      scale 0.3
      
      scale y*(1 + cos(clock * pi * 8)*0.0075)
      
      rotate y*90 
      
      translate<-2.4, 0.7, 0>
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
      translate <1.3,1,0.4>
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