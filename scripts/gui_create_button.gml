/// gui_create_button(gui,name,script[,value_color,width,height])
/*
    Create a button item
    
    name: item name
    script: callback script (execute when button is clicked)
    
    Optional:
    value_color: value and mark color
    width: item width (omit to use default size)
    height: item height (omit to use default size)
    
    return item reference
*/

var gui = argument[0];
var sets = gui[| 0];

var vcolor,width,height;

if argument_count < 4 vcolor = sets[9];
else vcolor = argument[3];             // value color
if argument_count < 5 width = sets[4];
else width = argument[4];             // width
if argument_count < 6 height = sets[5];
else height = argument[5];             // height

return _gui_create_item(argument[0], string(argument[1]), 3, argument[2], 0, 1, vcolor, width, height, -1, 148);
