///anim_damage(dir)

/* This script is used to animate the sprite rotation mimicing
     the paper mario style with out the need for seperate arm
     or leg sprites
   
   Make sure to account for player direction as the sprite will
     rotate in different styles based on the direction it rotated
     to, for instance when the player walks right, then up, then
     left. the front side (right) of the sprite will shrink at 
     it rotates to give the illusion it is further away from the 
     camera.
   
   Returns: Bool (True when animation is finished, False for any other state)
*/

returned = false


if !variable_instance_exists(self.id, "anim_damage_start") {anim_damage_start = true}


//set the animation variables
if (anim_damage_start)
{
  anim_dmg_active = true
  
  // anim_time is used to equate exactly how many frames the animation needs to take
  anim_time = floor(room_speed*0.3)
  
  // anim_timer is used to equate where the sin/cos wave currently is
  anim_timer = anim_time
  
  // anim_flip_frame is used to move the wave over, of course if you want to move it over exactly by half then you can just use sin() instead of cos()
  anim_flip_frame = floor(anim_time*0.5)
  
  // pi_time is just a method to make the wave it's self. multiplying pi_time will dictate how many times to wave peaks/vallies before it finishes the timer
  pi_time = pi / anim_time
  
  //this variable is used to keep track of the last view we did. 9 is a view which doesnt exist so it will think it's a new frame
  view_loop = 9
  
  // lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max
  max_x_multiplier = lengthdir_x(abs(sprite_width)*0.8, argument0)
  max_y_multiplier = lengthdir_y(abs(sprite_height)*0.8, argument0)
  
  // this variable is only used to make sure we only calculate the animation's variables once
  anim_damage_start = false
  
}


///notes to understand the cos and sin
//
// cos((anim_timer-anim_flip_frame) * pi_time)
// sin((anim_timer) * pi_time)
//
// anim_timer is used to equate where the wave currently is
// anim_flip_frame is used to move the wave over, of course if you want to move it over exactly by half then you can just use sin() instead of cos()
// pi_time is just a method to make the wave it's self. multiplying pi_time will dictate how many times to wave peaks/vallies before it finishes the timer
// lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max


/// a negative number means we were facing right, and we're turning left
// 3 wave peak
var trav_dis_x = (-cos(anim_time*pi_time*(anim_timer/anim_flip_frame)*1.25) * (anim_timer/(anim_time*0.8972256054)))  * max_x_multiplier
// 2 wave peak
//var trav_dis_x = (-sin(anim_time*pi_time*(anim_timer/anim_flip_frame)) * (anim_timer/(anim_time*0.8707991555)))  * max_x_multiplier
//var trav_dis_x = ((-cos(anim_timer *pi_time *(anim_timer/anim_time) *2))/2+0.5)  * max_x_multiplier
//var trav_dis_x = sin((anim_timer) * pi_time*2) * max_x_multiplier

// how much we skew the y for either the top or bottom of the player
// 3 wave peak
var trav_dis_y = (-cos(anim_time*pi_time*(anim_timer/anim_flip_frame)*1.25) * (anim_timer/(anim_time*0.8972256054)))  * max_y_multiplier;
// 2 wave peak
// var trav_dis_y = (-sin(anim_time*pi_time*(anim_timer/anim_flip_frame)) * (anim_timer/(anim_time*0.8707991555)))  * max_y_multiplier;
//var trav_dis_y = ((-cos(anim_timer *pi_time *(anim_timer/anim_time) *2))/2+0.5)  * max_y_multiplier
//var trav_dis_y = sin((anim_timer) * pi_time*2) * max_y_multiplier

/// a negative number means we were facing right, and we're turning left
//var trav_dis_x_head = ((-cos(anim_timer *pi_time *(anim_timer/anim_time) *2))/2+0.5)  * max_x_multiplier
//var trav_dis_x_head = sin((anim_timer) * pi_time) * max_x_multiplier

// how much we skew the y for either the front of back of the player
//var trav_dis_y_head = ((-cos(anim_timer *pi_time *(anim_timer/anim_time) *2))/2+0.5)  * max_y_multiplier
//var trav_dis_y_head = sin((anim_timer+anim_flip_frame*0.5) * pi_time*2) * max_y_multiplier

draw_set_color(image_blend)

draw_sprite_pos(body,
                image_index, 
                
                //top left
                x-(sprite_xoffset)+trav_dis_x,
                y-(sprite_yoffset)+trav_dis_y,
                
                //top right
                x+(sprite_width-sprite_xoffset)+trav_dis_x, 
                y-(sprite_yoffset)+trav_dis_y,
                
                //bottom right
                x+(sprite_width-sprite_xoffset),//+trav_dis_x, 
                y+(sprite_height-sprite_yoffset),//+trav_dis_y,
                
                //bottom left
                x-(sprite_xoffset),//+trav_dis_x, 
                y+(sprite_height-sprite_yoffset),//+trav_dis_y*1.5,
                
                image_alpha);

draw_sprite_pos(head,
                image_index, 
                
                //top left
                x-(sprite_xoffset)+trav_dis_x,
                y-(sprite_yoffset)+trav_dis_y,
                
                //top right
                x+(sprite_width-sprite_xoffset)+trav_dis_x,
                y-(sprite_yoffset)+trav_dis_y,
                
                //bottom right
                x+(sprite_width-sprite_xoffset),//+trav_dis_x,
                y+(sprite_height-sprite_yoffset),//+trav_dis_y_head,
                
                //bottom left
                x-(sprite_xoffset),//+trav_dis_x,
                y+(sprite_height-sprite_yoffset),//+trav_dis_y_head,
                
                image_alpha);



//this will keep track of the view ports we've iterated through, that way we never count down the anim timer more then once each frame
if (view_current < view_loop) || (global.numberOfLocalPlayers = 1){
  view_loop = view_current
  anim_timer -= 1*lag()
}else if (view_current > view_loop){
  view_loop = view_current
}



if (anim_timer <= 0)
{
  returned = true
  anim_damage_start = true
  anim_dmg_active = false
  
  anim_time = 0
  anim_timer = 0
  anim_flip_frame = 0
  pi_time = 0
  view_loop = 9
  max_y_multiplier = 0
  max_x_multiplier = 0
  anim_idle_start = 1
  anim_walk_start = 1
  anim_rotate_start = 1
  anim_damage_start = 1
}

draw_set_color(c_white)

return returned


