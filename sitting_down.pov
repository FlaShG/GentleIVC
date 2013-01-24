

#include "table.inc"                                                                
#include "tea.inc"
#include "spoon.inc"
#include "pocket_watch.inc"
#include "utah_teapot.inc"
//#include "clock_skysphere.inc"

#include "alice.inc"

  
//#declare camera_offset_to_look_at = <-7 , 1 , -1> * .4;

//#declare camera_look_at = <2,1.2,0>;
//#declare camera_offset_to_look_at = <10 , 1 , 10> * .1;




//#declare animation_duration                                    
                                   
                     
#macro special_clock(special_clock_start, special_clock_end, special_clock_full_duration)
 clip(
   (clock - ((special_clock_start)/(special_clock_full_duration)))
    * (special_clock_full_duration) / ((special_clock_end) - (special_clock_start)),
     0, 1)
#end                    
                                  
//WICHTIG!!!
#declare animation_duration = 4;
#declare run_start = 0;
#declare run_end = 3.0;

#declare head_start = 2.8;
#declare head_end = 4;
#declare turn_start = 2.8;
#declare turn_end = 3.8;
                                     
#declare cam_start = 0;
#declare cam_end = 3;
                                     
//#declare run_factor = animation_duration / (run_end - run_start);
#declare run_clock = special_clock(run_start, run_end, animation_duration); //clip((clock - (run_start/animation_duration)) * animation_duration / (run_end - run_start), 0, 1);
#declare head_clock = special_clock(head_start, head_end, animation_duration);//clip(clock * run_factor, 0, 1);
#declare turn_clock = special_clock(turn_start, turn_end, animation_duration);//clip(clock * run_factor, 0, 1);
#declare cam_clock = special_clock(cam_start, cam_end, animation_duration);//clip(clock * run_factor, 0, 1);

#declare alice_position_z = +2 - 1.5*run_clock -0.5*turn_clock;                             

 
#declare schritte = 15;         

#declare sinus = sin(run_clock * schritte);
#declare sinus1 = (sinus+1) / 2;

#declare cosinus = cos(run_clock * schritte);
#declare cosinus1 = (cosinus+1) / 2;
                              
                
#declare alice_position = <2.3,
                 0 + 0.5/0.68*(-(turn_clock - 0.8)*(turn_clock - 0.8) + 0.8*0.8),
                 alice_position_z>;                
                                                                


#declare camera_look_at = alice_position + y*0.7 - 5*x - 10*z;// <2,1.2,0>+<-5,0,-10> + y*0.5;                                           
//#declare camera_look_at = <2,1.2,0>+<-5,0,-10> + y*0.5;                                           
#declare camera_offset_to_look_at = 1*vrotate(1.5*<-3 , 2 , -1> * .4 *(2-cam_clock*cam_clock), 100*(1-cam_clock)*y);
//#declare camera_offset_to_look_at = <0,10,0>;

camera
{
   location (camera_look_at + camera_offset_to_look_at)
   look_at camera_look_at
   focal_point camera_look_at
   aperture 0.05  
   blur_samples 25
   right x*image_width / image_height
}  
   
#declare light_vector = <-20, 30, -10>;   
light_source
{
   light_vector*2000 0.4
} 
light_source
{
   light_vector*-2000 0.07 shadowless
} 


object
{
   pocket_watch(7, 20, 48+floor(clock*animation_duration))
   scale 30
   translate y*-1.64
} 

       

merge
{
   object
   {
      tea_table
      translate<0,0,0>
   }
   
   //teacups
   /*object{
      teacup_and_spoon_on_saucer
      scale 0.15
      translate y
   } */
   
   object{
      //spoon_in_teacup_on_saucer 
      spoon_on_saucer
      scale .15
      translate <1.8, 1, 0>
   }    
   
   object
   {
      //teacup
      empty_teacup 
      scale .12   
      rotate y*-80
      
      translate <-0.2, 0, 0>
      
      //rotate z*-52*sip_clock
      
      //translate <2.5-0.45-((1-sip_clock)*0.05), 1, 0>
      translate <2.5-0.45-(1*0.05), 1, 0>
   }
   
   #declare base_arm_l1 = y*-48 + z*-5;
   #declare base_arm_l2 = y*-70 + z*-15;
   #declare base_arm_r1 = y*-20 + z*-30;
   #declare base_arm_r2 = y*-40 + z*170;
   
   
   object
   {
      //alice(-z*50, y*-(100-10*sinus1) -x*sinus1*10,
      //      -z*50, y*-(100-10*sinus1) -x*sinus1*10)
            
      //alice      
      alice_with_hr
            (-z*50 + y*-(sinus*30), y*-110,
            -z*50 + y*-(-sinus*30), y*-110,
            (head_clock - turn_clock)*90*y)  
            
      //ready_alice 
      
//      scale 0.2
//      scale y * (1+sin(clock * schritte * 2) * 0.02)
//      scale z * (1+cos(clock * schritte * 2) * 0.02)
//      translate <31, 0, alice_position_z>    
      scale 0.3
      
      scale y * (1+sin(run_clock * schritte * 2) * 0.02)
      scale z * (1+cos(run_clock * schritte * 2) * 0.02)
      rotate y*180
      rotate y*turn_clock*90
      
      translate alice_position

   }  
/*   object
   {
      //ready_alice
      alice(base_arm_l1 + y*8*sip_clock + z*5*sip_clock,
            base_arm_l2 + y*-50*sip_clock + z*-20*sip_clock,
            base_arm_r1, base_arm_r2)
      
      scale 0.3
      rotate y*-90
      translate x*2.3 + y*0.5
   }
  */ 
   object
   {
      chair
      rotate y*-90
      translate <2.3 , 0.0 , 0>
   }
            

   object
   {
      teacup_and_spoon_on_saucer
      scale 0.15
      rotate y*94
      translate y + x*-1.6
   }
   
   object
   {
      gentleman
      
      scale 0.3
      
      rotate y*90 
      
      translate<-2.4, 0.5, 0>
   }
   
   object
   {
      chair
      rotate y*90
      translate <-2.4 , 0.0 , 0>
   }
   
   object
   {
      utah_teapot
      scale .09  
      
      rotate y*49
      translate <-0.4,1,0.4>
   }             
   object
   {
      utah_teapot
      scale .09  
      
      rotate y*49
      translate <1.3,1,0.4>
   } 
   
   translate <-5,0,-10>
}




// mirrors

/*union
{
   box {
      2, <-2,-2,2.1>
      no_reflection  
      pigment{ color White }  
      finish { reflection 1 ambient 0.01 diffuse 0 }    
      rotate y*45
   }       
   box {
      2, <-2,-2,2.1>
      no_reflection  
      pigment{ color White }  
      finish { reflection 1 ambient 0.01 diffuse 0 }    
      rotate y*-45
   }    
   box {
      <-5,0,-5> <5,-1,5>
      no_reflection  
      pigment{ color White }  
      finish { reflection 0.1 ambient 0.05 diffuse 0 }    
   }
   
   translate z*.5
}*/ 
