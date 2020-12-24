///draw_laser(path, [width])

var sprite = spr_laser
var particle = prt_sparkle
var pathIndex = argument[0]


//////////primitive
texture_set_repeat(true)
draw_set_color(c_white)
quality =  path_get_number(pathIndex)*4
q = 1 / quality

if (argument_count >= 2){
  width = argument[1]/2
}else{
  width = sprite_get_width(sprite)/2
}

length = path_get_length(pathIndex)

oldX = path_get_point_x(pathIndex, 0)
oldY = path_get_point_y(pathIndex, 0)

newX = path_get_x(pathIndex, 0)
newY = path_get_y(pathIndex, 0)

draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sprite, 0))
for (i = q; i <= 1; i += q)
{
    nextX = path_get_x(pathIndex, min(i + q, 1))
    nextY = path_get_y(pathIndex, min(i + q, 1))
    
    //Divide [dx, dy] by its own length to turn it into a unit vector (a vector with length 1)
    d = point_distance(nextX, nextY, oldX, oldY)
    dx = (nextX - oldX) / d
    dy = (nextY - oldY) / d
    oldX = newX
    oldY = newY
    newX = nextX
    newY = nextY
    
    //[dx, dy] is parallell to the path. This means that [dy, -dx] is perpendicular to the path
    draw_vertex_texture(oldX + dy * width, oldY - dx * width, i * length / width, 0)
    draw_vertex_texture(oldX - dy * width, oldY + dx * width, i * length / width, 1)
    /*
    draw_particle_line(particle,
                   oldX+dx, //x1
                   oldY+dy, //y1
                   newX, //x1
                   newY) //y1
    */
}
draw_primitive_end()
//////////


//////////draw last line
var last_point = path_get_number(pathIndex)-1
draw_sprite_line_shader(sprite, 
                    path_get_point_x(pathIndex, last_point), //x1
                    path_get_point_y(pathIndex, last_point), //y1
                    x, //x2
                    y) //y2
//////////


//////////draw particles
/*
for (var i = 0; i < last_point; i++){
  draw_particle_line(particle,
                     path_get_point_x(pathIndex, i), //x1
                     path_get_point_y(pathIndex, i), //y1
                     path_get_point_x(pathIndex, i+1), //x1
                     path_get_point_y(pathIndex, i+1)) //y1
}

draw_particle_line(particle,
                   path_get_point_x(pathIndex, last_point), //x1
                   path_get_point_y(pathIndex, last_point), //y1
                   x, //x2
                   y) //y2
/*
//////////
