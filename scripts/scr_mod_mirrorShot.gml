/// scr_mod_mirrorShot()


if (w_type = weapon_type_range) || (melee_ranged > 0){
  
  var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_mirrorShot)
  
  var shots_to_spawn = mod_count
  var max_angle = 360/(shots_to_spawn+1)
  
  
  while ds_queue_size(self.recent_proj_queue) != 0{
    var _proj = ds_queue_dequeue(self.recent_proj_queue)
    
    
    for (var i = 1; i <= shots_to_spawn; i++){
      
      var new_proj = instance_create(x, y, obj_weap_proj);
      
      ds_queue_enqueue(self.proj_queue, new_proj)
      
      ///set variables for new projectile
      var distance = ((owner_id.sprite_width*owner_id.image_xscale)/2 + (owner_id.sprite_height*owner_id.image_yscale)/2) /2 +1;
      new_proj.direction = _proj.direction + (max_angle * i)
      
      new_proj.x = owner_id.x+lengthdir_x(distance, new_proj.direction)
      new_proj.y = owner_id.y+lengthdir_y(distance, new_proj.direction)
      
      new_proj.owner_weap = id
      
    }
  }
}

//reload the new projectiles into the original queue
if (mod_count = 1){
  if ds_queue_size(self.recent_proj_queue) = 0{
    ds_queue_copy(self.recent_proj_queue, self.proj_queue)
  }
}


return true



/*

if (w_type = weapon_type_range) || (melee_ranged > 0){
  var _dir = direction-180
  
  var distance = ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2) /2 +1
  
  xx = owner_id.x+lengthdir_x(distance, _dir);
  yy = owner_id.y+lengthdir_y(distance, _dir);
  
  var new_proj = instance_create(xx, yy, obj_weap_proj)
        
  ds_queue_enqueue(self.recent_proj_queue, new_proj)
  ds_queue_enqueue(self.proj_queue, new_proj)
  ///set variables for new projectile
        
  new_proj.direction = _dir
  
  new_proj.owner_weap = id
      
        
}

return true
