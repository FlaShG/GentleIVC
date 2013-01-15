#include "gentle.inc"  
#include "math.inc"

#declare camera_look_at = <0,2,0>;                                           
#declare camera_offset_to_look_at = <-5, 1, 12> * 0.5;
      
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   //aperture 0.2 
   //blur_samples 50
   right x*image_width / image_height
}

light_source
{
   <-22,42,42>*200 color White    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}

object
{
  talking_gentleman(clip( sin(clock * pi * 2) * 50 , -20, 20 ))
}                                                              
                    

/*
#declare i = 0;
#while(i < 0.04)
   text
   {
      ttf "CASTELAR.ttf"
      "yes indeed"
      0.25
      0
      pigment{ color rgbt<1,0,0,(i*22.5)> }             
      scale 0.4
      translate<1,2,0>
      rotate<0,180 + (clock-i) * 720,0>    
   } 
   #declare i = i+0.002;
#end
*/