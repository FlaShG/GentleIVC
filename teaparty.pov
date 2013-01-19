

#include "table.inc"                                                                
#include "tea.inc"


#declare camera_look_at = <0,1,0>;                                           
#declare camera_offset_to_look_at = <1-2*clock,.5-clock, 1>*.7;
//#declare camera_offset_to_look_at = <0,1, 0>;
                                                                
camera
{
   location (camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.25  
   //blur_samples 250
   right x*image_width / image_height
}  
 
light_source
{
   10 1
}  

object
{
   tea_table
   translate<0,0,0.3>
}    


//teacups
object
{
   teacup_on_saucer
   scale 0.15
   translate y*1
}


// mirrors
box {
   -2, <2,2,-2.1>
   no_reflection  
   pigment{ color White }  
   finish { reflection 1 ambient 0.01 diffuse 0 }    
   rotate y*45
}       
box {
   -2, <2,2,-2.1>
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