#include "nice_functions.inc"

 
#include "math.inc" 
#include "rand.inc"
#include "shroom.inc"
#include "colors.inc"
#include "skies.inc"  
#include "stars.inc"  


#ifndef ( random )
   #declare random = seed (1338);
#end
            
               
               
               
               
#macro transform_lookatme(myPosition)
   transform
   {
      rotate y*rand(random)*360*0
      
      #local shroom_look_pos = <i_x * 2 + rand(random) - 0.5, 0, i_z * 2 + rand(random) - 0.5>;
      RotateTo_Transform(<0,0,1>, shroom_look_pos, myPosition, y)
      translate shroom_look_pos
   
   
   }
#end            

#macro transform_normalshroom()
   transform
   {
      rotate y*rand(random)*360
      translate <i_x * 2 + rand(random) - 0.5, 0, i_z * 2 + rand(random) - 0.5>
   
   }
#end            
                                        

#macro one_shroom_in_forest(looking, myPosition)
   object
   {                                                                                               
      #local shroom_height = clip((Rand_Gamma(2,1,random)*5),2,30);
      #local shroom_shear  = rand(random) * 0.3;
      #local shroom_top_radius = 1+(rand(random)*0.3);
      
      
      #local shroom_full_angle = rand(random)*360;
      #local shroom_full_pos = <i_x * 2 + rand(random) - 0.5, 0, i_z * 2 + rand(random) - 0.5>;
      
      #local shroom_top_angle = +RotateTo(<0,0,1>, shroom_full_pos*(1-y), myPosition*(1-y), y) - shroom_full_angle; 
      
      
      #if(looking)
         shroom_angle(shroom_height, shroom_shear, shroom_top_radius, shroomtexture, shroom_top_angle, true)
      #else
         shroom(shroom_height, shroom_shear, shroom_top_radius, shroomtexture, true)                        
      #end                                                                                                  
      
      
      rotate y*shroom_full_angle
      
      
      translate shroom_full_pos
   }
#end

                            
                            
#macro looking_shroom_forest(looking, myPosition) 
#declare i_x = -10;
#while(i_x < 50) 
        #declare i_z = -10;
        #while(i_z < 50)
                one_shroom_in_forest(looking, myPosition) 
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

box
{
   <-200,0,-200>
   <200,-5,200>
   texture
   {
      pigment
      {
         image_map
         {
            jpeg "gras.jpg"
            map_type 0
            interpolate 2
            
         } // end of image_map    
         rotate x*90
         scale 2
      } //  end of pigment
      
      /*normal
      {
         bump_map
         {
            jpeg "grasbump.jpg"
            bump_size 5.0
         }
         rotate x*90
         scale 2
      }*/
   } // end of texture
} 
#end

#macro more_looking_shroom_forest(looking, myPosition)
union
{
#declare i_x = 50;
#while(i_x < 100) 
        #declare i_z = 50;
        #while(i_z < 100)                                
                one_shroom_in_forest(looking, myPosition) 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end

#declare i_x = -10;
#while(i_x < 50) 
        #declare i_z = 50;
        #while(i_z < 100)
                one_shroom_in_forest(looking, myPosition) 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end 


#declare i_x = 50;
#while(i_x < 100) 
        #declare i_z = -10;
        #while(i_z < 50)
                one_shroom_in_forest(looking, myPosition) 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end
}
#end

#declare few_shrooms =
union
{
#declare i_x = -5;
#while(i_x < 5) 
        #declare i_z = -5;
        #while(i_z < 5)                                
                one_shroom_in_forest(off, 0) 
                #declare i_z = i_z+1;         
        #end
        
        #declare i_x = i_x+1;
#end 
}
                  

#macro some_shrooms()                      looking_shroom_forest(off, 0)           #end
#macro some_looking_shrooms(myPosition)    looking_shroom_forest(on, myPosition)   #end


#macro more_shrooms()                   more_looking_shroom_forest(off, 0)         #end
#macro more_looking_shrooms(myPosition) more_looking_shroom_forest(on, myPosition) #end
 