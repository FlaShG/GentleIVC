#include "gentle.inc"
#include "colors.inc"   
#include "skies.inc"  
#include "colorize_intersection.inc"
           
/*
#declare camera_look_at = <0,2,0>;
#declare camera_offset_to_look_at = <-2,1,7>; 
 
camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.25  
   //blur_samples 25
   right x*image_width / image_height
}*/

                                           
#macro lerp(p1, p2, amount)
   (p1) + (((p2)-(p1)) * (amount))
#end                                          
                                           
#macro arm(point1, point2, point3, surface1, surface2)   
   #local sp = spline
   {   
      natural_spline
     -0.1,  point1
      0.0,  point1
      0.05, lerp(point1, point2, 0.1)
      0.45, lerp(point1, point2, 0.9)
      0.5,  point2
      0.55, lerp(point2, point3, 0.1)
      0.95, lerp(point2, point3, 0.9)
      1.0,  point3
      1.1,  point3
   }
       
   #declare i = 0;
   #while(i <= 2)
      
      sphere
      {
         sp(i / 2)
         0.2 - (i * 0.05)
         texture
         {   
            #if(i <= 1)
               surface1
            #else
               surface2
            #end
         }
      }        
      #declare i = i + 0.01;           
   #end
   sphere
   {                     
      point3
      0.2
      texture{ surface2 }
   }
#end

#macro angled_arm(point1, l1, l2, angle1, angle2, mirrored, surface1, surface2)
   #declare mx = 1;
   #if(mirrored)
      #declare mx = -1;
   #end
   
   #local offset2 = vrotate(<mx * l1, 0, 0>, mx * angle1);
   #local offset3 = offset2+vrotate(vrotate(<mx * l2, 0, 0>, mx * angle1), mx * angle2);
   
   
   arm(point1, point1+offset2, point1+offset3, surface1, surface2)  
#end
   
   
#declare alice_skin_color = pigment{color rgb <0.8,0.6,0.3>};         
#declare alice_dress_color = pigment{color rgb<0.5,0.6,1>};   
#declare alice_hair_color = pigment{color rgb<0.9,0.9,0.3>};
   
#macro alice_arm(start, angle1, angle2, mirrored)
    angled_arm(start, 1.1, 0.8, angle1, angle2, mirrored, texture{alice_dress_color finish{diffuse 2}}, texture{alice_skin_color finish{diffuse 2}})
    //angled_arm(start, 1, 0.9, angle1, angle2, mirrored, alice_dress_color, alice_skin_color)
#end   

         
#macro alice_body (head_rotation) 
merge
{
   colorize_intersection
   (
      cone
      {
         0, 1
         <0,2,0>, 0.4
         texture
         {
            alice_dress_color
            finish
            {
               diffuse 2
            }
         }
      }                         
      
      sphere
      {
         0,
         1
         scale<0.5,1.5,0.8>
         translate<0,2,0.4>
      }
      
      texture
      {
         pigment{ color White }
         finish
         {
            diffuse 2
         }
      }
   )

   merge
   {    
      sphere
      {
         0
         0.8      
         texture
         {
            alice_skin_color
            finish
            {
               diffuse 2
            }
         }
      }
      
      blob
      {
         threshold 0.5
         sphere
         {
            0,
            0.5
            1
            scale <2,1,2.5>
            rotate z*45
            translate <-0.4,0.4,0>
         }
         
         sphere
         {
            0,
            0.5
            1
            scale <2,1,2.5>
            rotate z*-45
            translate <0.4,0.4,0>
         }
         
         sphere
         {
            0,
            0.5
            1
            scale <3,3.5,2>
            translate <0,-0.3,-0.35>
         }  
         
         texture
         {
            alice_hair_color
            finish
            {
               diffuse 2
            }
         }
      }                  
      
      object
      {
         fancy_bowtie                         
         scale 2 
         rotate x*44
         translate<0,0.8,-0.7>
         texture
         {
            pigment{ color rgb<0.1,0.1,1> }
            finish
            {
               diffuse 2
            }
         }
      }     
      
      /*#local alice_eye =
      sphere
      {
         0
         0.3
         scale<0.2,0.6,0.0001>
         translate<0,0,0.8>
         pigment{ color rgb<0,0,0.09> }
      }
      
      object
      {
         alice_eye
         rotate y*16
      }           
      
      object
      {
         alice_eye
         rotate y*-16
      }*/
                
      rotate (head_rotation)
      translate <0,2.7,0>
   }
   
   /*arm
   (
      <0.2,2,0>
      <0.8,1.4,0>
      <1.0,0.8,0>
      alice_dress_color
      alice_skin_color
   )
   arm
   (
      <-0.2,2,0>
      <-0.8,1.4,0>
      <-1.0,0.8,0>
      alice_dress_color
      alice_skin_color
   )*/
   
}   

#end 

#macro alice(r_1, r_2, l_1, l_2)
union
{
   object{ alice_body (0)}
     
   alice_arm
   (
      <0.2,2,0>,
      r_1,
      r_2,
      false
   )
   
   alice_arm
   (
      <-0.2,2,0>,
      l_1,
      l_2,
      true
   )
}
#end  

#macro alice_with_hr(r_1, r_2, l_1, l_2, h_r)
union
{
   object{ alice_body (h_r)}
     
   alice_arm
   (
      <0.2,2,0>,
      r_1,
      r_2,
      false
   )
   
   alice_arm
   (
      <-0.2,2,0>,
      l_1,
      l_2,
      true
   )
}
#end
 
                                                           
#macro ready_alice_with_hr(h_r)
object
{
   alice_with_hr(z*-50, y*-100, z*-50, y*-100, h_r)
}
#end
                                                           
                                                           
#declare ready_alice = ready_alice_with_hr(0);//alice(z*-50, y*-100, z*-50, y*-100);
   
/*
#declare alice =
union
{
   object{ alice_body }
     
   alice_arm
   (
      <0.2,2,0>,
      z*-50,
      y*-100,
      false
   )
   
   alice_arm
   (
      <-0.2,2,0>,
      z*-50,
      y*-100,
      true
   )
}
*/
/*object
{
   alice
}

object
{
   alice
   rotate y*90 
   translate x*2.3
}

object
{
   alice      
   rotate y*180 
   translate x*-2.3
}  

light_source
{
   <0,42,42> 1.0
} */  
            
//sky_sphere{ S_Cloud5 }