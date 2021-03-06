///draw_sprite_line_shader(sprite, subimg x1, y1, x2, y2, [width])

var sprite = argument[0]
var subimg = argument[1]
var x1 = argument[2]
var y1 = argument[3]
var x2 = argument[4]
var y2 = argument[5]

//find out what the ideal width is
  if (argument_count = 7){
    ideal_width = argument[6]
  }else{
    ideal_width = sprite_get_height(sprite);
  }

//grab the image length, relative to the image scale
  if (ideal_width != sprite_get_width(sprite)){
    var scale = ideal_width / sprite_get_height(sprite)
  }else{
    var scale = 1
  }

// set the length so we dont have to do the math for it every time we need it.        
  ideal_length = sprite_get_width(sprite)*scale
    

//find the direction, and how much to add to x and y for each
  var _dir = point_direction(x1, y1, x2, y2)
  var _dist = point_distance(x1, y1, x2, y2)

  var scl = _dist / ideal_length;
  
  var xx = mean(x1,x2);
  var yy = mean(y1,y2);

texture_set_repeat(true);
shader_set(shStretch);
shader_set_hue(owner_id.fav_hue)
shader_set_uniform_f(shader_get_uniform(shStretch, "stretch"), scl);
draw_sprite_ext(sprite, subimg, xx, yy, scl, scale, _dir, draw_get_color(), 1);
shader_reset();
