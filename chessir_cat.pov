#include "colors.inc"
#include "skies.inc"
#include "stars.inc"
#include "colorize_intersection.inc"
#include "gentle.inc"
          
#declare random = seed(42);          
                                                      
#declare camera_look_at = <0,2,0>;                                           
#declare camera_offset_to_look_at = <0, 0, 1>*5.5;

/*sphere
{ 0, 1
  hollow
  texture
  {            
     Starfield3 scale 0.2      
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
}*/     
    
     
                    
camera
{
   location (camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.25  
   //blur_samples 250
   right x*image_width / image_height
}           


// --- new stuff
     
#macro cat_tooth (height)
cone
{
   <0,(height/100),0>, 0
   <0,0,0>, 0.175 
   texture
   {  
      finish
      {
         specular .25 
         roughness 0.0005  
      }  
      
      pigment
      {
         color rgb 0.75
      }               
      
      normal { dents 0.042 scale 0.005 }
   }       
   
   scale y*100   
}
#end           

#macro cat_tooth2 (height)
#declare tooth_spline =
spline
{     
   cubic_spline 
   -1 <0,-height,-height*0.25>
   0 <0,0,0>
   0.25 <0,height*0.25,height*0.05>
   0.6 <0,height*0.6,height*0.05>
   1 <0,height,-height*0.025>  
   2 <0,height*2, -height*0.2>
}  
#declare ctr = 0;     
merge{
#while (ctr <= 1)
   sphere
   {
      tooth_spline(ctr)
      0.15 - 0.125*ctr   
      scale 0.5 
      hollow
   }
   #declare ctr = ctr + 0.005;
#end  
hollow
}
texture
{  
   finish
   {
      specular .25 
      roughness 0.0005  
   }  
      
   pigment
   {
      color rgb 0.75
   }               
     
   normal { dents 0.042 scale 0.005 }
}   

#end

#macro cat_claw (height)  
intersection
{
   difference
   {
      cone
      {
         <0,2,0>, 0
         <0,0,0>, 0.175
         scale <0.25,1,1>
      }                
      sphere
      {
         <0,0.6,-1.5>, 1.5
      }   
   }   
   sphere
   {
      <0,0,-1.5>, 1.6 
      scale<0.08,1,1>
   }
}         
texture
{  
   finish
   {
      specular .25 
      roughness 0.0005  
   }  
      
   pigment
   {
      color rgb 0.75
   }               
     
   normal { dents 0.042 scale 0.005 }
}       
#end               
   
#declare cat_eyeball =
colorize_intersection
(
   sphere
   {
      0, 1   
      texture
      {
      pigment
      {
         spiral2 42
            color_map{[0.0 color rgbt <0,0,0,0.42>]
                      [0.5 color rgbt <0.25,0.25,0,0.42>]
                      [0.5 color rgbt <0,0.42,0,0.01>]
                      [1.0 color rgbt <0,0,0,0.01>]
                     }
      }
      normal
      {
         spiral2 40 
         bump_size 0.15
         sine_wave
      }  
      finish
      {
         ambient 0.1
      }     
      }     
         
      hollow
             
      interior
      {
         media
         {
            emission <0,0.25,0>
         }
      }
             
      scale <1.25,1.25,0.85>
   }    
   
   difference
   {
      sphere
      {
         z*0.75, 0.5
         scale <0.2,1,1>
      }
      sphere
      {
         0, 0.9
         scale <1,1,0.85>
      } 
   } 
   
   pigment
   {
      color Black
   }
)
   


#declare cat_eye =  
merge
{
light_source
{         
   0, rgb<0,0.05,0>
}        

sphere
{
   0, 1
   pigment
   {
     rgbt 1
   }    
   
   hollow
   
   scale <1.25,1.25,0.85>  
   
   interior{ //--------------------- lohmueller-stuff
    media{ method 3
           scattering
           { 1, 
              <1,1,1>*3.00 
              extinction 1.50
           }  

           density{ spherical 
                    turbulence 1//0.85
                    color_map {
                    [0.00 rgb 0]
                    [0.05 rgb 0]
                    [0.20 rgb <0,0.2,0>]
                    [0.30 rgb <0,0.6,0>]
                    [0.40 rgb <0,1,0>]
                    [1.00 rgb <0,1,0>]
                               }
           } 

           samples 1,1
           intervals 3   
           confidence 0.9  
     } // end of lohmueller-stuff
  }
}

intersection
{
  object { cat_eyeball }     
    
  intersection       
  
  {
     sphere
     {
        <-0.8,0.8,1>, 1.75
     }            
     sphere
     {
        <1.75,-2.75,1>, 3.5
     }
  }
}
}
 
#declare cat_eye2 =
union
{
intersection
{

sphere{
    <0,0,0>, 1
    pigment{rgbt 1}
    hollow
} //----- end of sphere    

sphere{
    <0,-1,0>, 1
    pigment{rgbt 1}
    hollow
 
} //----- end of sphere   

interior{ //-----------
 media{
  emission <0,0.5,0>
  scattering{1,<0,0.5,0>   extinction 1.5}
  absorption<1,1,0> 
  density{ bozo
    turbulence 0.5
    frequency 25
    color_map {
     [0.0 rgb <0,0,0>]//border
     [0.5 rgb <0,0.5,0>]
     [1.0 rgb <0,1,0>]//center
     } // end color_map
   } // end of density 
   density{ spherical
    turbulence 0.2              
    color_map {
     [0 rgb 0]//border
     [1 rgb 1]//center
     } // end color_map
   } 
  } // end of media ---
 } // end of interior
 rotate <5,0,20>
 scale <1.25,1.25,0.85>
}
      sphere
      {
         <.6,-0.5,2>, 0.5
         scale <0.2,1.25,0.2>
      
      pigment
      {
         color Black
      }  
      }
}   

#declare chessir_head =
union
{
sphere
{
   y*2, 2   
   scale <0.8,1.25,1>
   hollow
   pigment { rgbt 1 }
   interior
   {
      media
      {
         emission <0.3,0.3,0.1>
         
         density
         {
            spherical
            turbulence 1
            color_map
            {
               [0 rgb 0]
               [1 rgb 0.5]
            }
         }
      }
   }
}
sphere
{
   y*2, 1
   scale x*2 
   pigment { rgbt 1 }
   interior
   {
      media
      {
         emission <0.3,0.3,0.1>
         
         density
         {
            spherical
            turbulence 2
            color_map
            {
               [0 rgb 0]
               [1 rgb 0.5]
            }
         }
      }
   }  
} 
}      

#declare chessir_teeth = 
union
{
object{cat_tooth2 (0.75) translate <-0.1,0,-0.05>}
object{cat_tooth2 (0.75) translate <-0.3,0.03,-0.05>}
object{cat_tooth2 (1) rotate <5,-5,0> translate <-0.5,0.06,-0.1>}
object{cat_tooth2 (0.75) rotate <5,-7.5,0> translate <-0.7,0.09,-0.125>} 
object{cat_tooth2 (0.75) rotate <5,-10,0> translate <-0.9,0.12,-0.15>}
object{cat_tooth2 (0.7) rotate <5,-12.5,0> translate <-1.1,0.15,-0.175>}
object{cat_tooth2 (0.65) rotate <5,-15,0> translate <-1.3,0.2,-0.2>}                                                  
object{cat_tooth2 (0.5) rotate <5,-17.5,0> translate <-1.5,0.3,-0.225>}  
object{cat_tooth2 (0.45) rotate <5,-20,0> translate <-1.7,0.45,-0.25>} 
object{cat_tooth2 (0.4) rotate <5,-22.5,0> translate <-1.9,0.6,-0.275>} 
                                                     
object{cat_tooth2 (0.75) translate <0.1,0,-0.05>}
object{cat_tooth2 (0.75) translate <0.3,0.03,-0.05>}
object{cat_tooth2 (1) rotate <5,5,0> translate <0.5,0.06,-0.1>}
object{cat_tooth2 (0.75) rotate <5,7.5,0> translate <0.7,0.09,-0.125>}
object{cat_tooth2 (0.75) rotate <5,10,0> translate <0.9,0.12,-0.15>}
object{cat_tooth2 (0.7) rotate <5,12.5,0> translate <1.1,0.15,-0.175>}
object{cat_tooth2 (0.65) rotate <5,15,0> translate <1.3,0.2,-0.2>}  
object{cat_tooth2 (0.5) rotate <5,17.5,0> translate <1.5,0.3,-0.225>}
object{cat_tooth2 (0.45) rotate <5,20,0> translate <1.7,0.45,-0.25>}
object{cat_tooth2 (0.4) rotate <5,22.5,0> translate <1.9,0.6,-0.275>}                                                    
                                                      
                                                
object{cat_tooth2 (0.75) translate <-0.1,-0.8,0.05> scale <0,-1,0>}
object{cat_tooth2 (0.75) rotate y*-4.2 translate <-0.3,-0.83,0.05> scale <0,-1,0>}
object{cat_tooth2 (1.15) rotate <7.5,-7.5,0> translate <-0.5,-0.86,0> scale <0,-1,0>}  
object{cat_tooth2 (0.75) rotate <7.5,-10,0> translate <-0.7,-0.89,-0.125> scale <0,-1,0>} 
object{cat_tooth2 (0.75) rotate <7.5,-12.5,0> translate <-0.9,-0.92,-0.15> scale <0,-1,0>}
object{cat_tooth2 (0.7) rotate <7.5,-15,0> translate <-1.1,-0.95,-0.175> scale <0,-1,0>} 
object{cat_tooth2 (0.7) rotate <7.5,-17.5,0> translate <-1.3,-0.98,-0.2> scale <0,-1,0>} 
object{cat_tooth2 (0.7) rotate <7.5,-20,0> translate <-1.5,-1.01,-0.225> scale <0,-1,0>} 
object{cat_tooth2 (0.7) rotate <7.5,-22.5,0> translate <-1.7,-1.1,-0.25> scale <0,-1,0>}  
object{cat_tooth2 (0.7) rotate <7.5,-25,0> scale 0.9 translate <-1.9,-1.15,-0.275> scale <0,-1,0>}

object{cat_tooth2 (0.75) translate <0.1,-0.8,0.05> scale <0,-1,0>}
object{cat_tooth2 (0.75) rotate y*4.2 translate <0.3,-0.83,0.05> scale <0,-1,0>}       
object{cat_tooth2 (1.15) rotate <7.5,7.5,0> translate <0.5,-0.86,0> scale <0,-1,0>}  
object{cat_tooth2 (0.75) rotate <7.5,10,0> translate <0.7,-0.89,-0.125> scale <0,-1,0>}
object{cat_tooth2 (0.75) rotate <7.5,12.5,0> translate <0.9,-0.92,-0.15> scale <0,-1,0>}
object{cat_tooth2 (0.7) rotate <7.5,15,0> translate <1.1,-0.95,-0.175> scale <0,-1,0>}
object{cat_tooth2 (0.7) rotate <7.5,17.5,0> translate <1.3,-0.98,-0.2> scale <0,-1,0>} 
object{cat_tooth2 (0.7) rotate <7.5,20,0> translate <1.5,-1.01,-0.225> scale <0,-1,0>} 
object{cat_tooth2 (0.7) rotate <7.5,22.5,0> translate <1.7,-1.1,-0.25> scale <0,-1,0>} 
object{cat_tooth2 (0.7) rotate <7.5,25,0> scale 0.9 translate <1.9,-1.15,-0.275> scale <0,-1,0>}

}

#declare chessir_lips = 
union
{

difference
{
   intersection
   {
      sphere
      {
         y*2, 2.5
         pigment { rgbt 1 }
      }
      sphere
      {
         y*3, 3
         pigment{ rgbt 1 }
      } 
      
      scale z*0.4     
   }
   
   sphere
   {
     y*3.5, 3.25
   }
}      

difference
{
   intersection
   {
      sphere
      {
         y*3.6, 3.
         pigment { rgbt 0 }
      }
      sphere
      {
         y*4.85, 4
         pigment{ rgbt 1 }
      } 
      
      scale z*0.4     
   }
   
   sphere
   {
     y*5.1, 4
   }
}      

} 

                          
#declare chessir_mouth =
union
{

difference
{
   object{chessir_teeth}
   object{chessir_lips translate <0,-0.2,-0.3>}   
}

object
{
   chessir_lips
   translate <0,-0.3,-0.3>
   /*interior
   {
     media
     {
        emission <0,0.5,0>
        density
         {
            spherical
            turbulence 0
            color_map
            {
               [0 rgb 0]
               [1 rgb <1,0,0>]
            }
         }
     }
   }*/
       
   no_image
   no_reflection
       
   pigment { rgbt 0 }
}
    
}


/*object{cat_tooth2(0.75) translate <-0.1,0,-0.05>}
object{cat_tooth2(0.75) translate <-0.3,0.03,-0.05>}
object{cat_tooth2(1) rotate <5,-5,0> translate <-0.5,0.06,-0.1>}
object{cat_tooth2 (0.75) translate <-0.7,0.09,-0.125>} 
object{cat_tooth2 (0.75) translate <-0.9,0.12,-0.15>}

object{cat_tooth2 (0.75) translate <0.1,0,-0.05>}
object{cat_tooth2 (0.75) translate <0.3,0.03,-0.05>}
object{cat_tooth2 (1) rotate <5,5,0> translate <0.5,0.06,-0.1>}
object{cat_tooth2 (0.75) translate <0.7,0.09,-0.125>}
object{cat_tooth2 (0.75) translate <0.9,0.12,-0.15>}                                                      
                                                      
                                                
object{cat_tooth2(0.75) translate <-0.1,-0.8,0.05> scale <0,-1,0>}
object{cat_tooth2(0.75) rotate y*-4.2 translate <-0.3,-0.83,0.05> scale <0,-1,0>}
object{cat_tooth2(1.15) rotate <7.5,-7.5,0> translate <-0.5,-0.86,0> scale <0,-1,0>}  
object{cat_tooth2 (0.75) translate <-0.7,-0.89,-0.125> scale <0,-1,0>} 
object{cat_tooth2 (0.75) translate <-0.9,-0.92,-0.15> scale <0,-1,0>}

object{cat_tooth2 (0.75) translate <0.1,-0.8,0.05> scale <0,-1,0>}
object{cat_tooth2 (0.75) rotate y*4.2 translate <0.3,-0.83,0.05> scale <0,-1,0>}       
object{cat_tooth2 (1.15) rotate <7.5,7.5,0> translate <0.5,-0.86,0> scale <0,-1,0>}  
object{cat_tooth2 (0.75) translate <0.7,-0.89,-0.125> scale <0,-1,0>}
object{cat_tooth2 (0.75) translate <0.9,-0.92,-0.15> scale <0,-1,0>} */             
              
object{cat_eye2 translate <2,5.2,-0.2> scale 0.75}  
object{cat_eye2 translate <2,5,-0.2> scale <-0.75,0.75,0.75>}
                                                
object{chessir_mouth}                                                
                                                
/*object{chessir_teeth}
object{chessir_lips translate <0,-0.15,-0.3>} */
                                
                                
light_source
{
   42 0.5
}  

/*intersection
{

sphere{
    <0,0,0>, 1
    pigment{rgbt 1}
    hollow
} //----- end of sphere    

sphere{
    <0,0.5,0>, 1
    pigment{rgbt 1}
    hollow
 
} //----- end of sphere   

interior{ //-----------
 media{
  emission <0,1,0>
  scattering{1,<0,0.5,0>}
  density{ bozo
    turbulence 0.5
    frequency 20
    color_map {
     [0.0 rgb 0.0]//border
     [0.5 rgb <0,0.1,0>]
     [1.0 rgb <0,0.5,0>]//center
     } // end color_map
   } // end of density 
   density{ spherical
    turbulence 0.2              
    color_map {
     [0 rgb 0.0]//border
     [1 rgb 0.75]//center
     } // end color_map
   }
  } // end of media ---
 } // end of interior
 translate <0,1.00,0>

}        */