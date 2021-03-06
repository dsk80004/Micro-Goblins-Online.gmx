///scr_mod_summon_DESIGN()


///DESCRIPTION: What the mod should do
// Modcount = What does mod count effect
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_DESIGN)+1
  
  
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_MOD_NAME_start"){
    //store what ever values are needed
    mod_summon_MOD_NAME_timer = room_speed
    mod_summon_MOD_NAME_start = false
    
    //stat buffs
  }
  
  
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_MOD_NAME_start){
    
    
    //Secondary init, this is only activated on the second frame after every mod has be activated once, this is only a percasionary effect to make sure everything has added to values if needed.
    if !variable_instance_exists(self, "mod_summon_MOD_NAME_init"){
      mod_summon_MOD_NAME_init = true;
    }
    
    
    
    /////look for inputs/////
      //if possessed, grab player inputs
      if is_possessed{
        var possessed_vector_x = possesser_id.down - possesser_id.up;
        var possessed_vector_y = possesser_id.right - possesser_id.left;
      }else{
        var possessed_vector_x = ideal_vector_x;
        var possessed_vector_y = ideal_vector_y;
      }
      
      //grab the desired inputs for this mod, sometimes they are the given inputs, or manipulated inputs, sometimes they are the mirrored inputs of the enemy.
      var mod_vector_x = ideal_vector_x;
      var mod_vector_y = ideal_vector_y;
      
      //add the two inputs as desired, or simply take the player inputs, either way.
         //This is also where you will add any bias to the movements
      var true_vector_x = clamp( mod_vector_x + possessed_vector_x, -1, 1);
      var true_vector_y = clamp( mod_vector_y + possessed_vector_y, -1, 1);
    /////////////////////////  
    
    
      
    ///if cooldown is needed
    mod_summon_MOD_NAME_timer -= 1*lag()
    if !mod_summon_MOD_NAME_timer{
      //change active states, or what ever
    }
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_MOD_NAME_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_MOD_NAME_start = true
  }
  
  
}


//only ever return true if the modifier is no longer needed, doing so will remove one of the modifier from the queue.
return false
