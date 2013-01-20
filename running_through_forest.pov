
#include "rand.inc"
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
#include "alice.inc"
#include "chessir.inc"

                                                      
#declare camera_look_at = <31, 0.5, 15.4 + clock*12>;                                           
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
 
 
#declare schritte = 20;         

#declare sinus = sin(clock * schritte);
#declare sinus1 = (sinus+1) / 2;

#declare cosinus = cos(clock * schritte);
#declare cosinus1 = (cosinus+1) / 2;
 
       
object
{
   //alice(-z*50, y*-(100-10*sinus1) -x*sinus1*10,
   //      -z*50, y*-(100-10*sinus1) -x*sinus1*10)
         
   alice(-z*50 + y*-(sinus*30), y*-110,
         -z*50 + y*-(-sinus*30), y*-110)  
         
   //ready_alice 
   
   scale 0.2
   scale y * (1+sin(clock * schritte * 2) * 0.02)
   scale z * (1+cos(clock * schritte * 2) * 0.02)
   translate <31, 0, 15.4 + clock*12>    
}     


object
{
   //chessir_cat(5)
   sphere
   {
      0 1
   }
   scale 0.3
   translate <31.4, 1, 15.4 + clock*12>
}


light_source
{
   <-22,42,42>*200 color rgb <0.757, 0.682, 0.612>*0.05 shadowless    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
} 
   
//====================scene====================
                           
//#include "shroomforest.inc"
