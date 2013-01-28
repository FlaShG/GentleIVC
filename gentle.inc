#include "colors.inc"
#include "colorize_intersection.inc"

#declare head =
colorize_intersection
(
   sphere
   {    
       0
       1      
       texture
       {
         pigment{ color rgb <0.8,0.6,0.3> }
         finish
         {
            diffuse 2
         }
       }
   }   
   
   box
   {
       <-2,0,-2>
       <2,2,2>
       rotate <-50,0,0>
       translate <0,0,-0.2>
   }
   
   texture
   {
      pigment
      {
          color rgb 0.2
      }
      finish
      {
         diffuse 2
      }
   }
)
      
#declare classy_hat =
colorize_intersection
(
   merge
   {
       cylinder
       {
           <0,0.1,0>
           <0,1.6,0>
           0.8
       }    
       cylinder
       {
           <0,0,0>
           <0,0.1,0>
           1.4
       }    
       
       texture
       {
         pigment{ color rgb 0.1 }
         finish{ specular 0.1 }
       }
   }
   
   cylinder
   {
      <0,0.2,0>
      <0,0.4,0>
      2
   }   
   
   pigment{ color White }
)    
   
#declare ridiculous_stache =
merge
{
   sphere
   {
      0
      0.3
      pigment{ color Red }
   }
}    
    
#declare stache_spline =
spline
{     
   cubic_spline 
   -1 <-1,1,0>
   0  <0,0,0>
   1  <1,-0.3,0>
   2  <2,0.1,0>
   3  <2,1,0>
}                     
   
#declare half_stache =
blob
{   
   threshold 0.6
        #declare ctr = 0;
        #while (ctr <= 2)
          sphere
          {
            stache_spline(ctr)
            0.8-(ctr * 0.3)   
            1
            scale 0.5
          }
          #declare ctr = ctr + 0.05;
        #end         
                     
        pigment{ color rgb 0.2 }
}                          

#macro talking_stache(talk)
   merge
   {
      object
      {
         object{half_stache}
         rotate<0,0,talk>
         translate<0.2,.001*talk,0>
      }
      object
      {
         object{half_stache}
         rotate<0,0,talk>  
         scale<-1,1,1>      
         translate<-0.2,.001*talk,0>
      }   
      
      scale 0.8
   }  
#end
   
#declare stache = talking_stache(0);
    
#declare monocle =  
union
{
   intersection
   {
      sphere
      {
         <0,0,-0.45>
         1
      }   
           
      sphere
      {
         <0,0,0.45>
         1
      }  
          
      scale <1,1,0.35> * 0.25
           
      texture
      {
         pigment{ color rgbt<0.7,0.7,1,0.5> } 
         finish{ reflection 0.1 diffuse 2 }
      }
   }
   
   
   torus
   {
      0.24
      0.03
      rotate <90,0,0>
      
      texture
      {
         pigment{ color Gold }
         finish
         {
            diffuse 2
         }
      }
   }
}  
#declare bowtie =
merge
{
   sphere
   {
      0 0.8
   }    
   
   sphere
   {
      0 2
      scale <1,0.8,0.1>
      translate <1.9,0,0>
   }                    
   sphere
   {
      0 2
      scale <1,0.8,0.1>
      translate <-1.9,0,0>
   }      
   
   pigment
   {
      color rgb <0.9,0.2,0.2>
   }
   
   scale 0.13
}   
#declare fancy_bowtie_spline =
spline
{     
   cubic_spline 
   -1 <-1.5,0.5,0>
   0 <-1.45,0.25,0>    
   1 <-1,0.15,0>
   2 <-0.5,0.1,0> 
   3 <0,0.05,0>
}         
#declare half_fancy_bowtie =
blob
{   
   threshold 0.6
        #declare ctr = 0;
        #while (ctr <= 2)
          cylinder
          {
            fancy_bowtie_spline(ctr)
            fancy_bowtie_spline(ctr)*<1,-1,1>
            0.5-(ctr * 0.2)  // oder - 0.25
            1
            scale <0.5,0.5,0.2>
          }
          #declare ctr = ctr + 0.05;
        #end         
}                      
#declare fancy_bowtie =
merge
{
   object
   {
      object{half_fancy_bowtie}
      translate<0.2,0,0>
   }
   object
   {
      object{half_fancy_bowtie}  
      scale<-1,1,1>
      translate<-0.2,0,0>
   }     
            
   sphere
   {
      0
      1
      scale<0.17,0.15,0.1>
   }
   texture
   {
      pigment{ color rgb <0.9,0.05,0.05> }
      finish{ phong 0.05 diffuse 2 }
   }
   scale 0.42
} 
#declare gentle_body =       
colorize_intersection
(
   merge
   {
      sphere
      {
         <0,1.2,0>
         1      
      }
   
      cylinder
      {
         <0,1.2,0>
         0
         1
      }  
      texture
      {
         pigment
         {
            color rgb 0.1
         }
         finish
         {
            specular 0.1
         }
      }
   }
   
   cone
   {
      <0,2.2,0> 1
      <0,1.6,0> 0.2        
      scale <0.6,1,1>
      translate <0,0,1.1>
   }                     
   
   pigment
   {
      color rgb 0.9
   }
)

#macro talking_gentleman(talk)
   merge
   {
      object
      {
         head   
         translate <0,3,0>
      }
      
      object
      {
         classy_hat
         translate <0,3.6,0>
      }     
      
      object
      {
         talking_stache(talk)
         translate <0,2.9,0.9> 
      }  
      
      object
      {
         monocle 
         translate <0.33,3.34,1>
      }  
      
      object
      {
         fancy_bowtie               
         translate <0,2.1,0.7>         
      }
      
      object
      {
         gentle_body
      }
   }
#end

#macro looking_gentleman(look) 
   merge
   {
      merge
      {
         object
         {
            head   
            translate <0,2,0>

         }

         object
         {
            classy_hat
            translate <0,2.6,0>
         } 
         
         object
         {
            talking_stache(0)
            translate <0,1.9,0.9> 
         }
         
         object
         {
            monocle 
            translate <0.33,2.34,1>
         }  
         
         rotate (look)
         translate y
      }     
      
      object
      {
         gentle_body
      }     
      object
      {
         fancy_bowtie               
         translate <0,1.96,0.73>         
      }
   }
#end       

#macro looking_gentleman2(look, talk) 
   merge
   {
      merge
      {
         object
         {
            head   
            translate <0,2,0>

         }

         object
         {
            classy_hat
            translate <0,2.6,0>
         } 
         
         object
         {
            talking_stache((talk))
            translate <0,1.9,0.9> 
         }
         
         object
         {
            monocle 
            translate <0.33,2.34,1>
         }  
         
         rotate (look)*y
         translate y
      }     
      
      object
      {
         gentle_body
      }     
      object
      {
         fancy_bowtie               
         translate <0,1.96,0.73>         
      }
   }
#end

#declare gentleman = talking_gentleman(0);
  
#declare bubble =
sphere
{      
   0 0.1
   texture
   { 
      pigment
      {
         color rgbt <1,1,1,0.8>
      }
      finish
      {
         irid {0.35 thickness 0.5 turbulence 0.42}
      }
   }   
} 
#declare bubble_pipe =
difference
{
   merge
   {
      sphere
      {
         0
         1
      }    
              
      cone
      {
         <0,0,0> 0.4
         <0,0,-3> 0.2
      }
   }          
   
   sphere
   {
      0
      0.5              
      scale <1,3,1>
      translate <0,1,0>
   }
    
   texture
   {         
      pigment
      {   
         color rgb <0.5,0.2,0>
      }   
      finish
      {
         phong 1
      }
      
   }
            
   scale 0.2
}
/*#declare active_bubble_pipe =
merge
{
   object{ bubble_pipe }
   
   #declare i = my_initial_clock;
   #while(i < my_final_clock)
       
      #declare r_x = (rand(random)-0.5) * 2;
      #declare r_y = (rand(random)+1) * 2;
      #declare r_z = rand(random);
                
      #declare clock2 = my_clock - i;                
      #if(clock2 > 0)
         object
         {
            bubble
            scale clock2 + 0.4
            translate <0,0.2,0>                 
            translate <r_x * clock2, r_y * clock2, r_z * clock2> 
         }    
      #end
                
      #declare i = i+my_clock_delta;
   #end
}   
  
#declare piped_gentleman =
merge
{
   object{ gentleman }
   object
   {
      active_bubble_pipe         
      rotate <16,0,0>
      translate <0,2.5,1.2> 
      rotate <0,12,0>
   }
}    */