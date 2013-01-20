#include "math.inc"
#include "functions.inc"
#include "transforms.inc" 







/*
 *
 *
 */
#macro RotateTo(faceDirection, facePos, targetPos, rotAxis)
   #local lookatDirection = (targetPos) - (facePos);
   
   
   #local rotAngle = VRotationD(faceDirection, lookatDirection, rotAxis);
   
   
   rotAngle

#end


#macro RotateTo_Transform(faceDirection, facePos, targetPos, rotAxis)
                                        
   #local axisProjector = (1-vnormalize(rotAxis));
   Axis_Rotate_Trans
   (
      rotAxis, 
      RotateTo(faceDirection, facePos * axisProjector , targetPos * axisProjector , rotAxis)
   )
#end


