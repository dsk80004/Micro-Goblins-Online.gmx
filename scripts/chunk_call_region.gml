///chunk_call_region(world_x, world_y)

var xx = argument0;
var yy = argument1;

if (sign(xx) = -1) {var x_sign = -1} else {var x_sign = 0}
if (sign(yy) = -1) {var y_sign = -1} else {var y_sign = 0}

var cell_x = (xx div chunk_width) + x_sign
var cell_y = (yy div chunk_height) + y_sign

//Spiral generation
    var _x, _y, dx, dy, t, maxI;
    _x = 0;
    _y = 0;
    dx = 0;
    dy = -1;
    t = max(cell_x, cell_y);
    maxI = t*t;
    for(var i =0; i < maxI; i++){
        if ((-chunk_dist <= _x) && (_x <= chunk_dist) && (-chunk_dist <= _y) && (_y <= chunk_dist)){
            // DO STUFF...
            chunk_call(cell_x+_x, cell_y+_y)
        }
        if( (_x == _y) || ((_x < 0) && (_x == -_y)) || ((_x > 0) && (_x == 1-_y))){
            t = dx;
            dx = -dy;
            dy = t;
        }
        _x += dx;
        _y += dy;
        if (_x > chunk_dist) && (_y > chunk_dist){
          break;
        }
    }



