#include "colors.inc"  
#include "textures.inc"  
#include "Woods.inc"
  
#declare table_texture =
   texture
   {
      pigment { DMFWood3 rotate x*20 scale .7 turbulence 0.1} 
      
      finish{ specular .2}
   }  
  
#declare table =
merge
{
   box
   {
      <-2,.8,-1>, <2,.9,1>  
   }
   
   box
   {
      <-1.8,.8,-.8>, <-1.9,0,-0.9>  
   }
   box
   {
      <1.8,.8,-.8>, <1.9,0,-0.9>  
   }
   box
   {
      <-1.8,.8,.8>, <-1.9,0,0.9>  
   }
   box
   {
      <1.8,.8,.8>, <1.9,0,0.9>  
   }                        
   
 
 
   texture {table_texture}
}

#declare tea_table =
merge
{
   object{ table }
   difference
   {
      box
      {
         <-2.04,.6,-1.02>, <2.04,1,1.02> 
      }
      
      box
      {
         <-2,.5,-1>, <2,.9,1> 
      }

      
      texture
      {
         pigment
         {
            image_map
            {
               jpeg "tischdecke.jpg"
               map_type 0
               interpolate 2
               
            }   
            rotate x*90
            scale 1
         }
      }
   }
}