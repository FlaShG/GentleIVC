// Sir Povington-Renderworth  
                    
                     
#include "colors.inc"
#include "skies.inc" 
#include "golds.inc"
#include "glass.inc"

#include "textures.inc"


#include "math.inc"
#include "shapes.inc"


#include "alice.inc"
#include "tea.inc"    

#include "stars.inc"   

#include "shroomforest.inc"

                                                 
            
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
         scale <0.3, 0.4, 0.2>*.75   // --------------------- to be adjusted
      }
  }      
  // Mostly taken from Lohmueller - END
  scale 100000
}     

object{
   few_shrooms
   scale 200
   translate x*900
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
         scale 42
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