// Sir Povington-Renderworth  
          
          
#include "rand.inc"
                     
/*#declare my_clock = 0.7;  
#declare my_initial_clock = 0;
#declare my_clock_delta = 0.2;
#declare my_final_clock = 1;     */
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random); //muss hier drin bleiben. frag mich nicht
                     
 
#include "gentle.inc"
#include "alice.inc"
#include "shroomforest.inc"

                                                      
#declare camera_look_at = <5,6,5>;                                           
#declare camera_offset_to_look_at = <-12.5, 3, -12> * .65;
#declare alice_position = <5,4.5,5> + <-3.7,2.84,-2.9>;
#declare sir_position = <5,4.5,5> + <-4.1,2.65,-2.6>;
      
camera
{
   location (1/*shouldbeclock*/+0.2)*(camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point alice_position
   aperture 0.1 
   blur_samples 25
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
   ready_alice       
   scale 0.2            
   rotate y*180
   translate alice_position
   
}

object
{
   looking_gentleman2(-20,0)
   scale 0.2
   rotate y*240
   translate sir_position
}  

object
{
   shroom(23, 0, 1.2, shroomtexture, false)   
   rotate y*180
   translate <1.3, 0, 2.1>    
}      
   
   
#declare text_base_pos = alice_position+y*2+x*2 + 4.5*z;   
   
union
{
text
{
    ttf "EMPIREN.ttf" "Alice" .25, x*.2 

    texture
    {
       pigment {color Black}
       finish { specular .1 phong .1 ambient .2}
    }
          
    translate -.1*x      
}     
object
{
   stache          
   scale .2
   translate x*-.025 + y*.375
}  

text
{
    ttf "EMPIREN.ttf" "Splendid!" .2, x*.2 

    texture
    {
       pigment {color Black}
       finish { specular .1 phong .1 ambient .2}
    } 
    
    scale .25+.2*x
            
    //rotate x*20+y*5       
            
    translate -y+-1.65*x
    
}
text
{
    ttf "EMPIREN.ttf" " - Gentleman's" .2, x*.2 

    texture
    {
       pigment {color Black}
       finish { specular .1 phong .1 ambient .2}
    } 
    
    scale .1+.2*x
    
    translate y*-1.25-2*x
    
}  
text 
{
    ttf "EMPIREN.ttf" "         Health" .2, x*.2 

    texture
    {
       pigment {color Black}
       finish { specular .1 phong .1 ambient .2}
    } 
    
    scale .1+.2*x
    
    translate y*-1.35-2*x
    
}  
text
{
    ttf "EMPIREN.ttf" "The Bee's Knees!" .2, x*.2 

    texture
    {
       pigment {color Black}
       finish { specular .1 phong .1 ambient .2}
    } 
    
    scale .25+.175*x 
    
    translate -y+.9*x
    
}
text
{
    ttf "EMPIREN.ttf" " - Stache Today" .2, x*.2 

    texture
    {
       pigment {color Black}
       finish { specular .1 phong .1 ambient .2}
    } 
    
    scale .1+.2*x
    
    translate y*-1.25+1.5*x
    
}                                     
scale 3
rotate y*45
translate text_base_pos
}    
   
//====================scene====================
                           
#include "shroomforest.inc"
some_shrooms()  
more_shrooms()   

light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}
