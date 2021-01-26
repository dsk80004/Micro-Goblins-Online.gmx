///scr_player_state_move(player_id_local, modifiers)

var player_id_local = argument[0]
var modifier = argument[1]

if (spd != 0)
{
  ///apply friction
  if (!ceil(right) && !ceil(left) && !ceil(down) && !ceil(up)) || 
  (right == left && up == down) ||
  (abs(spd) > min(point_distance(0, 0, (right-left), (down-up)), 1) * max_speed * (60/room_speed)) || 
  (self.player_state != e_player_state.move)
  {
    var spd_multiplier = sign(spd);
    var desired_spd = abs(spd);
    
    spd -= acceleration * spd_multiplier * (60/room_speed)
    
    var spd_multiplier_new  = sign(spd);
    
    //if we are close enough to the max speed and got dropped under it, then bring speed to equal it.
    if (desired_spd > max_speed * 60/room_speed)
    && (abs(spd) < max_speed * (60/room_speed))
      {spd = (max_speed * (60/room_speed)) * spd_multiplier}
    
    //if we have crossed over 0, set spd to 0
    if (spd_multiplier_new != spd_multiplier)
      && (spd_multiplier_new != 0)
      && (spd_multiplier != 0)
    {spd = 0}
    
    if (!ceil(right) && !ceil(left) && !ceil(down) && !ceil(up))
      {dir = direction}
  }
  
  show_debug_message("about to check for tile collisions")
  if place_free(x, y) && !chunk_tile_meeting_precise(x, y)
  {
    var xx = x+lengthdir_x(spd*lag(), dir)
    var yy = y+lengthdir_y(spd*lag(), dir)
    
    //add speed
    if place_free(xx, yy) && !chunk_tile_meeting_precise(xx, yy)
    {
      x = xx
      y = yy
      var spd_multiplier = sign(spd);
      if (spd_multiplier = 1){
        direction = dir
      }else{
        if (spd_multiplier = -1){
          direction = dir
        }
      }
      
      if !(is_interior(x, y)){ //if we're outside
        if !chunk_tile_free(x, y, "layer_structures"){ //if we're collided with a structure
            //activate structure activate script
            //var _struct = chunk_tile_find(x, y, "layer_structures")
            
            //this script will find the structure type aswell as all other needed data
            chunk_interior_create(x, y)
        }
      }
    }
    else  //if we have collided with something
    {  
      //flat wall check
      hype = fast_hype(sprite_width, sprite_height)
      
      //Check for solid objects aswell as solid tiles
      wall_dir = scr_draw_circle(x,y,hype*0.5*1.25,hype*1.25/21,false);
      //tile_dir = tile_collision_normal(x,y,hype*0.5*1.25,hype*1.25/21,false);
      
      if (abs(angle_difference(dir,wall_dir)) > 165)// || (abs(angle_difference(dir,tile_dir)) > 165)
      { //165 degrees is the magic number to allow the player to move around a flat wall if they are halfway off it already
        //move as close to the wall as possible
        for (var dis = spd*lag(); dis > 0; dis--){
          var xx = x+lengthdir_x(dis, dir)
          var yy = y+lengthdir_y(dis, dir)
          
          if (place_free(xx, yy)) && !chunk_tile_meeting_precise(xx, yy){
            x=xx
            y=yy
            spd -= dis
            break;
          }
        }
        
        //this check is only here to make sure that it actually is a flat wall instead of moving at the exact angle of two different slopes
        if !place_free(x+lengthdir_x(spd*lag(),dir-80),y+lengthdir_y(spd*lag(),dir-80))
          && !place_free(x+lengthdir_x(spd*lag(),dir+80),y+lengthdir_y(spd*lag(),dir+80))
        {
        spd = 0
        direction = dir
        exit;
        }else{ //if it's not a solid object check if we're dealing with a tiled object (only saves a few collision calls)
          if chunk_tile_meeting_precise(x+lengthdir_x(spd*lag(),dir-80), y+lengthdir_y(spd*lag(),dir-80))
            && chunk_tile_meeting_precise(x+lengthdir_x(spd*lag(),dir+80), y+lengthdir_y(spd*lag(),dir+80))
          {
          spd = 0
          direction = dir
          exit;
          }
        }
      }
      
      
      
      //this is used to help iterate each possible angle, so check left 10 degrees, then check right 10 degrees
      var collision_angle_precision = 15
      
      // which would be the prefered side
      var prefer = -sign(angle_difference(dir,direction))
      if (prefer = 0) prefer = -sign(angle_difference(dir,wall_dir))
      if (prefer = 0) prefer = 1
      
      for (var multiplier = 1; multiplier > -2; multiplier -= 2){
          for (var angle = 0; angle <= 100; angle += collision_angle_precision){
            var angle_to_check = dir + angle * multiplier * prefer
            //if (angle_to_check >= 360) angle_to_check -= 360;
            //if (angle_to_check < 0) angle_to_check += 360;
            
            //here we calculate speed relative to angle difference, so the player will slow down a bit on slopes
            //this only returns a multiplier, not the new speed
            var speed_multiplier = 0.5*abs(dcos(angle_difference(angle_to_check, dir))) + 0.5 //the 0.0 was 0.2, if the slope feels a bit to rough you can increase all slope speeds with this, or relative speeds with 0.8
            
            var xx = x+lengthdir_x(spd*speed_multiplier, angle_to_check)
            var yy = y+lengthdir_y(spd*speed_multiplier, angle_to_check)
            
            //show_debug_player(0,"angle = "+string(angle))
            //show_debug_player(0,"angle_to_check = "+string(angle_to_check))
            
            if place_free(xx, yy) && !chunk_tile_meeting_precise(xx, yy){
              x = x+lengthdir_x(spd*speed_multiplier, angle_to_check)
              y = y+lengthdir_y(spd*speed_multiplier, angle_to_check)
                
              if (object_index = obj_player){
                if (self.player_state = e_player_state.move){
                  direction = angle_to_check
                }
              }
              exit;
            }
          }
          if (angle >= 80) var collision_angle_precision = 10;
        }
      
      //if no possible exit was found, this code will get ran.
      /*
      if (xprevious = x) || (yprevious = y)
      {
      
      }
      */
    }
  }else{ //if self's place not free
    
    //add the check for being stuck
    /*
    if (xprevious != x) || (yprevious != y)
    {
      //you managed to move inside a solid
      var out_dir = direction-180//point_direction(x, y, xprevious, yprevious)
      move_outside_solid(out_dir, speed)
      
    } else {
      //you werent moving when you became stuck
      
    }
    */
  }
}
//else {sprite_index = spr_green}





