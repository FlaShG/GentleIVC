#macro colorize_intersection(a, b, surface)
   merge
   {            
      difference{object{a} object{b}}
      intersection{object{a texture{surface}} object{b texture{surface}}}         
   }
#end