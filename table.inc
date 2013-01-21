#include "colors.inc"  
#include "textures.inc"  
#include "woods.inc"
  
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

#declare chair =
merge
{
   box
   {
      <0.5 , 0.6 , 0.5> <-0.5 , 0.7 , -0.5>
   }
   
   box
   {
      <0.45, 0, 0.45> <0.35 , 0.6 , 0.35>
   }
   
   box
   {
      <-0.45, 0, 0.45> <-0.35 , 0.6 , 0.35>
   }
   
   box
   {
      <-0.45, 0, -0.45> <-0.35 , 0.6 , -0.35>
   }
   
   box
   {
      <0.45, 0, -0.45> <0.35 , 0.6 , -0.35>
   }
   
   difference
   {
      box
      {
         <0.5, 0.7, -0.5> <-0.5 , 1.8 , -0.45>
      }  
      
      box
      {
         <0.4, 0.8, -0.55> <-0.4, 1.05, -0.4>
      }
      box
      {
         <0.4, 1.7, -0.55> <-0.4, 2.1, -0.4>
      }
   }
   
   sphere
   {
      <-0.45, 1.8, -0.475> 0.08
   }
   
   sphere
   {
      <0.45, 1.8, -0.475> 0.08
   }
   
   scale 0.7 
   
   texture {table_texture scale 0.9}
}