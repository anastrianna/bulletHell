///@desc
if(is_undefined(startx) || is_undefined(starty)) { exit; }

if(point_distance(x, y, startx, starty) > range) {
	show_debug_message("suicide");
}

speed = movSpeed;