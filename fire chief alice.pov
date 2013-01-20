
#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "shroom.inc"

                                                      
#declare camera_look_at = <5.7, 4.2, 10.6>;                                           
#declare camera_offset_to_look_at = <-5, 0, -5> * 0.5;
      
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.2 
   blur_samples 50
   right x*image_width / image_height
}     

/*sphere
{
   camera_look_at
   0.2              
   texture
   {
      pigment
      {
         color Yellow
      }
      finish
      {
         ambient 1
      } 
   }
}*/
       
object
{
   shroom(100, 0, 1.2, shroomtexture, false) 
   translate <6, 0, 10.7>    
}
       
object
{
   alice(y*-50,y*-50, y*-50,y*-50)       
   scale 0.2   
   
   translate <0, 0, -0.2>
            
   rotate y*(180+clock*400)
   
   translate <6, 0, 10.7>
   translate y * (7-clock*7)
}

/*light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}*/ 
   
//====================scene====================
                           
#include "shroomforest.inc"
some_shrooms()