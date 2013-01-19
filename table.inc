#include "colors.inc"  
#include "textures.inc"  
#include "Woods.inc"

#declare camera_look_at = <0,0,0>;                                           
#declare camera_offset_to_look_at = <1-2*clock,.5-clock, 1>*3.5;
 
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

#declare table =
merge{
   box{
      <-2,.3,-1>, <2,.4,1>  
   }                        
   
   texture{
      pigment { DMFWood3 scale .5 turbulence 1} 
      
      finish{ specular .2}
   }
}


object{ table }



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
   -2, <2,2,-2.1>
   no_reflection  
   pigment{ color White }  
   finish { reflection 1 ambient 0.01 diffuse 0 }    
   rotate x*-90
} 