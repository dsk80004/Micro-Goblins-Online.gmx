///scr_mod_swiftness
//
//melee
//weap spawn modifier

//show_debug_message("swiftness")
while !ds_queue_empty(self.recent_weap_queue){
  var _weap = ds_queue_dequeue(self.recent_weap_queue);
    
  _weap.swiftness += 1
  _weap.w_damage = ceil((_weap.w_damage/1.5)*1.1)
}

ds_queue_copy(self.recent_weap_queue, self.weap_queue)

return true
