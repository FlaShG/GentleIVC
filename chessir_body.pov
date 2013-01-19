#include "colors.inc"
#include "skies.inc"
#include "stars.inc"   
#include "shapes.inc"

#declare camera_look_at = <0,0,0>;                                           
#declare camera_offset_to_look_at = <0,1, 1>*2.5;
 
camera
{
   location (camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.25  
   //blur_samples 250
   right x*image_width / image_height
}  
 
light_source
{
   2 1
}   

declare cat_skull=
sphere {
   0, .65    
   scale x*1.8+z*0.5
}                 

   
declare cat_ear =
difference{
prism {
    conic_sweep
    cubic_spline
    0,
    1,
    6,
    <.5,0>, <0,.4>, <.25,0>, <-.5,0>, <0,.4>, <-.5,0>   
   rotate x*180
}    

prism {
    conic_sweep
    cubic_spline
    0,
    1.2,
    6,
    <0,1>, <0,.5>, <.5,0>, <-.5,0>, <0,.5>, <0,1>
   
   rotate x*180
   translate <-.05, -.01, .2> 
 
}
   
   matrix  <1  , 0, 0, //  matrix-shear_y_to_x 
            1, 1, 0,
            0  , 0, 1,
            0  , 0, 0> 
   
   scale y*.75 scale .75
           
   rotate z*60        
}                      
    

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
   }
   #declare ctr = ctr + 0.1; //was 0.005
#end  
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
         
      }
      sphere
      {
         y*3, 3
         
      } 
      
      scale z*0.345  // was 0.4   
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
         
      }
      sphere
      {
         y*4.85, 4
         
      } 
      
      scale z*0.33  // was 0.4     
   }
   
   sphere
   {
     y*5.1, 4
   }
}  

pigment{ color rgbt 1 }    

} 

                          
#declare chessir_mouth =
union
{

difference
{
   object{chessir_teeth}
   object{chessir_lips translate <0,-0.2,-0.3>}   
}

/*object
{
   chessir_lips
   translate <0,-0.2,-0.3> 
   
   hollow
   
   interior
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
   }
   
   
       
   
   no_reflection 
       
   pigment { rgbt 1 }
}*/
    
}            

declare cat_head= 
union{
union{
object{cat_skull}                             
object{ cat_ear translate -.95*x+1.25*y+0.1*z }   
object{ cat_ear translate -.95*x+1.25*y scale x*-1 translate z*0.1}

hollow 

 pigment{ color rgbt 1 }
   
   interior
   {     
   
   media
   {
      absorption .25
      density
      {
         spherical
         color_map
         {
            [0 rgb 1]
            [1 rgb 1]
         }
      }
   }
  

   media
     {
        emission 1
	absorption 2 
	
	scattering{1,20}
	
	density
	{
	   granite  
	   turbulence 2.5 + sin(10*clock)*0.1
	   color_map
	   {
	      [0.0 color rgb 0]
	      [0.2 color rgb 0]
	      [0.25 color rgb 0]
	      [1.0 color rgb <.6,0,.05>]
	   }
	}
     
      scale 1
      translate <0.1, 0, 0>
     }
   }  
   
}

object{ chessir_mouth rotate x*15 scale .45 translate y*-.65+z*.18}

} 

object{cat_head translate y}


/*
// mirrors
box {
   -2, <2,2,-2.1>
   no_reflection  
   pigment{ color White }  
   finish { reflection 1 ambient 0.01 diffuse 0 }    
   rotate y*45
}       
box {
   -2, <2,2,-2.1>
   no_reflection  
   pigment{ color White }  
   finish { reflection 1 ambient 0.01 diffuse 0 }    
   rotate y*-45
}    
box {
   -2, <2,2,-2.1>
   no_reflection  
   pigment{ color White }  
   //finish { reflection 1 ambient 0.01 diffuse 0 }    
   rotate x*-90
} 
*/

#include "shroomforest.inc"  