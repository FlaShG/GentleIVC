// Sir Povington-Renderworth  
                    
                     
#include "colors.inc"
#include "skies.inc" 
#include "golds.inc"
#include "glass.inc"

#include "woods.inc"
#include "textures.inc"


#include "math.inc"
#include "shapes.inc"
                                                      


#macro PrintArray(arr)
   #local len =  dimension_size(arr, 1);    // number of elements
   
   #for (i, 0, len -1 , 1)             
          
         (arr[i])
   #end 
#end




#declare spoon_texture = texture { T_Gold_1B }




#declare spoon_laffe_upperpart =
intersection
{
   sphere { <0,0,0>, 1 scale <1,1.75,1> }
   box { <-1,0,-1>, <1,1.75,1> }
}

#declare spoon_laffe_lowerpart =
intersection
{
   sphere { <0,0,0>, 1   scale <1,1,1>}
   box { <-1,-1,-1>, <1,0.001,1>}
}

#declare spoon_laffe_full =
difference
{
   merge
   { 
      object { spoon_laffe_upperpart }
      object { spoon_laffe_lowerpart }
   }     
   
   box { 10*(x+y), -10*<1,1,-1> }
   
   scale z*0.5
}

#declare spoon_laffe =
difference
{
   object { spoon_laffe_full  scale 1.00*z }

   object { spoon_laffe_full  translate 0.000001*z }
 
   texture { spoon_texture }

}                       
      
      
                         

#declare spl = array[16]
{
   <0.5, -2.65>
   <0.5, -2.65>              
   <0.2, -2>
   <0.2, 0>  
   <0.5, 2>  
   
   <0.0, 3>
   
   <-0.5, 2>
   <-0.2, 0>  
   <-0.2, -2>
   <-0.5, -2.65>
   <-0.5, -2.65>
   <-0.5, -2.65>
   
   <0, -2.5>
   
   <0.5, -2.65>
   <0.5, -2.65>
   <0.2, -2>
   
}                         

#declare spoon_handle =
prism
{ 
   conic_sweep
   cubic_spline
   0.95 ,1 , dimension_size(spl, 1)
             
   PrintArray(spl)                                                 

   
   translate -0.975*y
   
   scale -2.2*y        
   
   rotate<90,0,0>      
} 
  



                         
#declare spoon =                          
merge
{
   object { spoon_laffe }            


   difference
   {
      merge
      {
         object { spoon_handle }
         object { spoon_handle scale <0.7,0.94, 0.35> translate 0.08*z }
        
         matrix<1, 0,   0, 
            0, 1, -0.15,
            0, 0, 1,
            0, 0, 0>
                     

         translate <0,-3.3,0.27>
         
         texture { spoon_texture }
      }
      
      object { spoon_laffe_full  scale 1.00*z }
   }                       

}
