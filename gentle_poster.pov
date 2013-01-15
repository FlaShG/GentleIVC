// Sir Povington-Renderworth  
          
          
#include "rand.inc"
                     
#declare my_clock = 0.7;  
#declare my_initial_clock = 0;
#declare my_clock_delta = 0.2;
#declare my_final_clock = 1;
#declare random = seed (1338);  
#declare gamma_random = Rand_Gamma(1,1,random);                   
                     
#include "colors.inc"
#include "skies.inc"  
#include "stars.inc"  
#include "math.inc" 
#include "gentle.inc"
#include "alice.inc"

                                                      
#declare camera_look_at = <5,4.5,5>;                                           
#declare camera_offset_to_look_at = <-12.5, 5, -12> * 0.5;
#declare alice_position = <5,4.5,5> + <-3.7,2.85,-2.9>;
#declare sir_position = <5,4.5,5> + <-4.1,2.65,-2.6>;
      
camera
{
   location (1/*shouldbeclock*/+0.2)*(camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point alice_position
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
   alice       
   scale 0.2            
   rotate y*180
   translate alice_position
   
}

object
{
   gentleman
   scale 0.2
   rotate y*220
   translate sir_position
} 

//==================current====================

#macro shroom(shroom_height, shroom_shear, shroom_top_radius, shroom_top_texture, shroom_gentle)   
   merge
   {
       blob
       {
          threshold 0.3
          sphere
          {
             0 1 1
          }     
          cylinder
          {
             0 y*((shroom_height)-0.5) 0.7 1
             translate y*0.8
          } 
          sphere
          {
             (shroom_height)*y 0.8 1
          }   
          
          texture
          {
             pigment { color White }    
             
             normal { agate 0.1 agate_turb 1 scale 1 }
          }                         
          
          
                                                      
          matrix<1  , 0, 0, //  matrix-shear_y_to_x 
        shroom_shear, 1, 0,
                 0  , 0, 1,
                 0  , 0, 0>                                                      
                                                      
          scale 0.3
       } 
       
       merge
       { 
          merge
          {
             sor
             {
                6
                <1.0,0.0>
                <1.0,0.2>
                <0.8,0.4> 
                <0.3,0.7>
                <0.02,0.8>
                <0.0,0.8>
                sturm
             
                translate y*-0.2 
             }
             
             difference
             { 
                torus
                {
                   1-0.15 0.15
                }
              
                box
                {
                   <2,0,2>
                   <-2,1,-2>
                }
             }
               
            scale 0.8 * <(shroom_top_radius),1,(shroom_top_radius)>  
         } 
          
       #if((shroom_gentle))
          object
          {
             stache
             scale 0.4
             translate z*0.8*(shroom_top_radius)
          }
       #end
       
          translate y*((shroom_height) * 0.3) + (x * (shroom_shear) * ((shroom_height) / 3.3))
          
          texture
          {
             shroom_top_texture
          }
       }
       

   }              
#end  
   
//====================scene====================
//floor

box
{
   <-200,0,-200>
   <200,-5,200>
 texture {
  pigment {
     granite
     turbulence 6
     color_map {
       [0.000 color rgb <0.5, 0.5, 0.2>]
       [0.25 color rgb <0.7, 1, 0.2>]
       [0.5 color rgb <1, 0.4, 0.2>]
       [0.75 color rgb <.5, 0.9, 0.2>]
       [1 color rgb <0.3, 0.9, 0.2>]
     }
     scale 5
   }
   finish{specular .25 }
           normal{
             average normal_map{
                 [0.0 bumps 150 scale 30]
                 [0.2 dents 50 scale 12.5 turbulence .3]
                 [0.6 bozo 20 rotate x*90
 rotate y*45 scale 30 ]
                 [1.0 wrinkles 25 scale 5 scallop_wave rotate z*30]
                 }//end of normal map
                 rotate z*15 turbulence .4
               }//end of normal dec
 }
} 

/* 
object
{   
   piped_gentleman 
   rotate <0,210,0>
   translate <0,0,0*4>
}
object
{   
   piped_gentleman 
   rotate <0,210,0>
   translate <0,0,1*4>
}
object
{   
   piped_gentleman 
   rotate <0,250,0>
   translate <0,0,2*4>
}
object
{   
   piped_gentleman 
   rotate <0,190,0>
   translate <-1.5,0,3*4>
}
object
{   
   piped_gentleman 
   rotate <0,190,0>
   translate <5,0,6>
}  
*/ 
                               
#declare shroomtexture =
texture
{
   pigment
   {
      crackle scale 0.8
      color_map
      {
         [0.00 color Red]
         [0.2 color Red]
         [0.25 color rgb 0.9]
         [0.60 color White]
      }
      scale 0.2
   }                               
   
   finish
   {
      diffuse 2
      reflection 0.042
   }
}
  
#declare i_x = -10;
#while(i_x < 50) 
        #declare i_z = -10;
        #while(i_z < 50)
                object
                {  
                   shroom(clip((Rand_Gamma(2,1,random)*5),2,30), rand(random) * 0.3, 1+(rand(random)*0.3), shroomtexture, true)
                   rotate y*rand(random)*360
                   translate<i_x * 2 + rand(random) - 0.5, 0, i_z * 2 + rand(random) - 0.5>
                } 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end 

#declare i_x = 50;
#while(i_x < 100) 
        #declare i_z = 50;
        #while(i_z < 100)
                object
                {  
                   shroom(clip((Rand_Gamma(2,1,random)*5),2,30), rand(random) * 0.3, 1+(rand(random)*0.3), shroomtexture, true)
                   rotate y*rand(random)*360
                   translate<i_x * 2 + rand(random) - 0.5, 0, i_z * 2 + rand(random) - 0.5>
                } 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end

#declare i_x = -10;
#while(i_x < 50) 
        #declare i_z = 50;
        #while(i_z < 100)
                object
                {  
                   shroom(clip((Rand_Gamma(2,1,random)*5),2,30), rand(random) * 0.3, 1+(rand(random)*0.3), shroomtexture, true)
                   rotate y*rand(random)*360
                   translate<i_x * 2 + rand(random) - 0.5, 0, i_z * 2 + rand(random) - 0.5>
                } 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end 

#declare i_x = 50;
#while(i_x < 100) 
        #declare i_z = -100;
        #while(i_z < 50)
                object
                {  
                   shroom(clip((Rand_Gamma(2,1,random)*5),2,30), rand(random) * 0.3, 1+(rand(random)*0.3), shroomtexture, true)
                   rotate y*rand(random)*360
                   translate<i_x * 2 + rand(random) - 0.5, 0, i_z * 2 + rand(random) - 0.5>
                } 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end
                  
light_source
{
   <-22,42,-42>*200 color rgb <0.757, 0.682, 0.612>*0.6    // moonlight according to   http://www.perbang.dk/rgb/C1AE9C/
}   
            
sphere
{ 0, 1
  hollow
  texture
  {            
     Starfield2 scale 0.2      
  }                            
  
  // Mosly taken from Lohmueller - BEGIN
   texture
   {
      pigment
      {
         bozo turbulence 0.75
         octaves 10  omega 0.7 lambda 2 
         color_map
         {
          [0.0  color rgb <0.95, 0.95, 0.95> ]
          [0.05  color rgb <1, 1, 1>*1.25 ]
          [0.15 color rgb <0.85, 0.85, 0.85> ]
          [0.55 color rgbt <1, 1, 1, 1>*1 ]
          [1.0 color rgbt <1, 1, 1, 1>*1 ]
         } 
         translate< 3, 0,-1>
         scale <0.3, 0.4, 0.2>*0.42   // --------------------- to be adjusted
      }
  }      
  // Mostly taken from Lohmueller - END
  scale 100000
}
      
fog
{
   fog_type   2
   distance   20
   color      White
   fog_offset 0.25
   fog_alt    0.75
   turbulence 1.8
}     

fog
{
   fog_type   2
   distance   6
   color      rgb <0.42,0.42,0.75>
   fog_offset 0
   fog_alt    0.42
   turbulence 1.8
}              
