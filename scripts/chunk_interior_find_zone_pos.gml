///chunk_interior_find_zone_pos(chunk_x, chunk_y)

var chunk_x = argument0;
var chunk_y = argument1;

if (object_index = obj_chunk){
  if variable_instance_exists(self, "interior_map"){
    zone_pos = interior_map[? "zone_pos"];
    return zone_pos;
  }
}

var world_chunk_width = global.chunk_handler.world_chunk_width
var world_chunk_height = global.chunk_handler.world_chunk_height

//now find the zone
var ext_chunk_x = chunk_x - world_chunk_width
var ext_chunk_y = chunk_y

var zones_per_col = global.chunk_handler.world_chunk_height div interior_zone_size

var zone_x = ext_chunk_x div interior_zone_size
var zone_y = ext_chunk_y div interior_zone_size

var zone_pos = zone_x*zones_per_col + zone_y

return zone_pos;



