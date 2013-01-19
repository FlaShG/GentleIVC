// Sir Povington-Renderworth  
                    
                     
#include "colors.inc"
#include "skies.inc" 
#include "golds.inc"
#include "glass.inc"

#include "textures.inc"


#include "math.inc"
#include "shapes.inc"
                                                      
#declare camera_look_at = <0, 0.5, 0>;                                           
#declare camera_offset_to_look_at = <0, 10, 0.0001> * 0.6;
      
/*camera
{
   location camera_look_at + camera_offset_to_look_at
   look_at camera_look_at
   focal_point camera_look_at
   //aperture 0.25  
   //blur_samples 25
   right x*image_width / image_height
}*/
//==================current====================

      
// arrays with numbers for the face, 
#declare arabicNumbers = array [12] { "1","2","3","4","5","6","7","8","9","10","11","12" };
#declare romanNumbers  = array [12] { "I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII" };
#declare romanNumbers2  = array [12] { "","","III","","","VI","","","IX","","","XII" };
// number a little bit shifted
#declare romanNumbers3  = array [12] { "I","","","IV","","","VII","","","X","","" };
#declare bars  = array [12] { "|","|","","|","|","","|","|","","|","|","" };
// compass :)
#declare compass  = array [12] { "","","O","","","S","","","W","","","N" };


/**
 *
 * numbers:      array with symbols  (the last element will be at 12 o'clock)
 * rad:          radius, from 0 to center of each symbol
 * font:         font for the symbols
 * obj_scale:    scale of each symbol
 * obj_material  material for each symbol
 * default_angle rotation around the center
 * rot:          the symbol-bottom faces to: 
 *                  true: 0    false: xz-plane     
 * 
 */
#macro writeNumbersToFace(numbers, rad, font,  obj_scale, obj_material, default_angle, rot)
    #local len =  dimension_size(numbers, 1); // number of elements
    #local da = 360 / len;                    // degrees per element
    #local a0 = (da + (default_angle));       // offset
    
    #local vec12 = y * rad;                      
    union
    {
        #for (n, 0, len -1 , 1)             
            #local a = (a0 + n*da);
            
            // define the textobject to calculate the center
            #local txtL = 
                text { ttf font , numbers[n], 0.02, 0.0 // thickness, offset
                                                              
                    material {obj_material}
                } 
            
            
            object 
            { 
                txtL                                             
                // translate center of symbol to 0
                translate -(min_extent(txtL)+max_extent(txtL))/2 
            
            
                scale (obj_scale)*0.2
                
                #if (rot)
                    translate vec12
                    rotate -z*a
                #else
                    translate vrotate(vec12, -z*a)
                #end
                
                rotate 180*y
            } 
        
        
        #end 
    }
    
#end

#macro test(numbers, rad, obj_scale, default_angle, rot)
    writeNumbersToFace(numbers, rad, "arial.ttf", obj_scale, material{texture{ pigment{ color Blue } normal { bumps 0.5  scale 0.01 } finish { phong 0.1 }}}, default_angle, rot)
    //writeNumbersToFace(numbers, rad,"arial.ttf", obj_scale, material{M_Vicks_Bottle_Glass}, default_angle, rot)
                      //normal { bumps 0.5  scale 0.01 }
                       // finish { phong 0.1 }
                      //} // end of texture
 
#end




#declare torusHight = 0.10;
#declare torusRadius = 1;


// ------------------ The frame of the clocl -------------------                
#declare border =
merge
{
    torus{ torusRadius, torusHight     translate<0,torusHight,0> }
    
    cylinder { 0, torusHight/2*y , 1}
  
    texture { T_Gold_1B }                  
}                     

#declare clockHandle = 
merge           
{               
    #local hrad = 0.08;
    #local hhight = 0.20;
    torus{ hrad, hhight/(3*2) translate hhight/(3*2) * 0.5 * y}
    torus{ hrad, hhight/(3*2) translate hhight/(3*2) * 2.4 * y}
    torus{ hrad, hhight/(3*2) translate hhight/(3*2) * 4.3 * y}
    
    object
    { 
        blob { threshold 0.1  cylinder { 0, y * hhight, hrad  1}}
        bounded_by {cylinder { 0, y * hhight * 2, hrad   }}
    }
    
    torus
    {
       0.1, 0.025
       
       scale x*2.2
       rotate 90*x
       
       
       translate hhight*1.5 * y
    }

    
    
    texture{T_Gold_1B}
}



// --------------------- the clock inside, glass, face, .... --------------------
#declare innerSpace = 
object
{
    cylinder
    {
            0.5*torusHight  * y,
            2.5*torusHight  * y ,                        
            torusRadius - torusHight/2
    }
                
    texture { T_Gold_1B }
}

#declare clockGlass =
intersection
{       
    #local hight = 0.1; 
    
    cylinder { 0, 1*y, 1 }
    sphere { 0, 1 }

    scale (torusRadius - torusHight/2) * (x+z) + hight *y
        
    material { M_Glass }
    translate y*torusHight*1.15
}             

#declare clockFace = 
merge
{
    cylinder
    {
        0.5*torusHight * y,
        0.9*torusHight  * y ,                        
        torusRadius - torusHight/2
                          
        pigment {color White}
            
    }
    merge
    {
        test(romanNumbers2, torusRadius - torusHight*2.0, 1.1, 0 , off) 
        test(bars, torusRadius - torusHight*2.0, <1, 0.5, 1>, 0 , on) 
                    
        rotate -x*90
        translate 0.901*torusHight * y
    } 
}




// ------------------   The Clock Hands ----------------------
#declare secondHand = 
merge
{
    blob             
    {
        threshold 0.6
                      
        cylinder
        {
            0.2*z,
            0*z,                        
            0.08
            
            1                  
            //pigment {color Green}
        }
        cylinder
        {
            0*z,
            -1*z,                        
            0.05
            
            1                  
            //pigment {color Red}
        }
         
        sturm       
        //texture { T_Gold_1B }
    }
    torus { 0.1, 0.02 }
}
#declare minuteHand = 
merge
{
    blob             
    {
        threshold 0.6
                      
        cylinder
        {
            0.2*z,
            0*z,                        
            0.08
            
            1                  
            //pigment {color Green}
        }
        cylinder
        {
            0*z,
            -1*z,                        
            0.05
            
            1                  
            //pigment {color Red}
        }
         
        sturm       
        //texture { T_Gold_1B }
    }
    torus { 0.1, 0.02 }
}
#declare hourHand = 
merge
{
    blob             
    {
        threshold 0.6
                      
        cylinder
        {
            0.2*z,
            0*z,                        
            0.08
            
            1                  
            //pigment {color Green}
        }
        cylinder
        {
            0*z,
            -1*z,                        
            0.05
            
            1                  
            //pigment {color Red}
        }
         
        sturm       
        //texture { T_Gold_1B }
    }
    torus { 0.1, 0.02 }
}





// the full pocket watch
#macro pocket_watch(time_hour, time_minute, time_second)
    
    #local frac_second = (mod(time_second, 60) / 60);
    #local frac_minute = (mod(time_minute + frac_second, 60) / 60);
    #local frac_hour   = (mod(time_hour +frac_minute , 12) / 12);
    
    
    #local angle_hour   = 360  * frac_hour;
    #local angle_minute = 360  * frac_minute;
    #local angle_second = 360  * frac_second;
    
    
    
    merge
    {                                           
        difference
        {
            object{border}
            object{innerSpace}
        }        
        object {clockHandle rotate x*-90 translate -(torusRadius+ torusHight)*0.98*z}
        clockFace
        object {secondHand scale z*torusRadius*0.9 translate torusHight*1.0*y rotate y*angle_second}
        object {minuteHand scale z*torusRadius*0.9 translate torusHight*1.1*y rotate y*angle_minute}
        object {hourHand   scale z*torusRadius*0.9 translate torusHight*1.2*y rotate y*angle_hour}
        
        clockGlass
    }
#end

/*pocket_watch(13, 31, 19)
                      
light_source
{
   <42,42,-42> 1.0
}   


            
sky_sphere{ S_Cloud5 }*/