// Sir Povington-Renderworth  
                    
                     
#include "colors.inc"
#include "skies.inc" 
#include "golds.inc"
#include "glass.inc"
#include "math.inc"


      
#declare porcelain =
texture
{
   pigment { rgb 1.3 }
   finish
   {
      reflection {0.05, 0.5 fresnel on } conserve_energy
      specular 1 roughness 0.005
      diffuse 0.5
   }
}      
      

#declare teacup_outershell =
sor
{
   7,
   //<2.5,  -0.5>,
   <3.5,   0.0>,
   <3.5,   1.3>,
   <4.5,   1.9>,
   <6.0,   4.0>,
   <7.0,  11.0>,
   <7.5,  11.5>,
   <8.5,  15>
    
   sturm
}
   
   
#declare teacup_innershell =
sor
{
   7,
   //<2.5,  -0.5>,
   <3.5,   0.0>,
   <3.5,   1.3>,
   <4.5,   1.9>,
   <6.0,   4.0>,
   <7.0,  11.0>,
   <7.5,  11.5>,
   <8.5,  15>
   
   sturm
   scale <0.95 1.001 0.95>
} 

#declare teacup =
union // tea + cup
{
   merge // teacup
   { 
      difference
      {
         object {teacup_outershell }
         object {teacup_innershell }
      }                             
      difference
      {
         cylinder
         {
            0
            <0 2.3 0>
            3.5   
            //pigment{color Blue}
         }
         sphere
         {
            -10*y
            10.5
            //pigment{color Green}
         }
      }

// handle
      sphere_sweep
      {
         //linear_spline                 // linear curve
         //cubic_spline                // alternative spline curves
         b_spline
         10,                            // number of specified sphere positions
         < 4.5,  1.9, 0>, 0.2                // position, radius
         < 4.7,  2.0, 0>, 0.3
         < 4.8,  2.1, 0>, 0.5
         < 6.5,  4.5, 0>, 0.5
         < 9.0,  5.5, 0>, 0.5
         <11.0, 10.0, 0>, 0.5
         <11.5, 11.7, 0>, 0.9
         //<10.0, 12.0, 0>, 0.5
         //<10.0,12.0, 0>, 0.5
         < 9.0,   9.0, 0>, 0.5
         < 6.5, 11.0, 0>, 0.5
         < 6.5, 11.0, 0>, 0.4
  
         tolerance 0.1             // optional
      }

      //texture { T_Gold_1B }  
      //pigment { Col_Glass_Orange}
      //pigment { color Red}
             
             
      texture{ porcelain }

   } // teacup end

   #declare tea_in_teacup =           
   merge
   {
      // tea :)     
      difference
      {
         object { teacup_innershell }
         box {<-10, 8 ,-10>, <10, 20 ,10> rotate 0*(z*15+ x*9)}
      } 
      scale 0.999
      material
      {
         texture
         {
            pigment{ rgbf<0.7, 0.25, 0.02, 0.3>}//  <.93,.95,.98,0.825>*0.99}
            finish
            {
               ambient 0.0 diffuse 0.15
               reflection{0.1,0.1 }
               specular 0.6 roughness 0.005
               conserve_energy
            } // end finish
         } // end of texture
   
         interior
         {
            ior 1.33
            fade_power 1001
            fade_distance 0.5
            fade_color <0.9998,0.8,0.8>
            caustics 0.16
         } // end of interior
      } // end of material
              
   }  
   
   
   intersection
   {
      //object {tea_in_teacup}
      object
      {
         tea_in_teacup
         normal { ripples 2.35 scale 0.325 turbulence 0.5 translate<-1.55,0,0> rotate<0,-50,0>} 
      }         
   }     
           
   cylinder
   {
      y*3.5
      y*15 - x*7
      1
      pigment {color Green}
   }                                                           


   #declare steam =
   cylinder
   {
      <0,0,0>, <0,3.5,0>, 1.5  // increased from 1 to 1.5, because of the turbulent pattern !!!
      pigment {rgbt 1}
      hollow  
   
      interior
      { //---------------------
         media
         {
            method 3
            emission 0.6
            scattering
            {
               1, // Type 1 = isotropic scattering, 2 = Mie haze, 3 = Mie murky 
                  // Type 4 = Rayleigh scattering,  5 = Henyey-Greenstein scattering 
               <0.5,1,2>*0.05        // color of scattering haze  
               extinction  .50    // 0 ~ 1 extinction 
               // how fast the scattering media absorbs light 
               // useful i.e. when the media absorbs too much light
               // eccentricity i.e. -0.6 ~ +0.6 (if type>1 )
            }  // end scattering   

            #declare ex = x;
            #declare ey = y;
            #declare ez = z;   
            #declare calc_m_x = function(a)
                 {  1*sin(2.5*(a-clock)) }
            #declare calc_m_z = function(a)
                 //{  1*cos(8*(a-clock)) }
                 {  0 }
            #declare calc_var = function(a)
                 { 20 }
            #declare calc_max = function(a)
                  { 1-2*y/3.7 }      
                   
            density
            {  
               function
               {   
                  //clip(1*exp(-2*((calc_m(y)-x)*(calc_m(y)-x) + z*z)), 0, 1)
                  clip(calc_max(y)*exp(-calc_var(y)*((calc_m_x(y)-x)*(calc_m_x(y)-x) + (calc_m_z(y)-z)*(calc_m_z(y)-z))), 0, 1)
                  //min(4.2*pow(1-(y+clock)/3.7, 2)*exp(-2*(x*x + z*z)), 1)     
                  //clock+5*exp(-x*x - 0.1*y*y - z*z)
               }
               //turbulence 0.85
               //turbulence 0
                 
               //translate y*clock
            }  
              
            samples 3,3     // 3,3 for adaptive sampling
            intervals 3     //  
            confidence .9   //  
         } // end of media ----------------------------------------------------------------------
      } // ------------------ end of interior
      scale 4.5 
      rotate<0,0,0>
      translate < 0, 7 ,0> 
   } //------------------ end of "Rauch" 


   steam
            

   scale 0.1
   //rotate -x*30  +y*80
   //rotate z*20
   //translate 5*y
  
}


