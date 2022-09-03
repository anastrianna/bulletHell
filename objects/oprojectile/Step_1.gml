///@desc
if(is_undefined(startx) || is_undefined(starty)) { exit; }

if(point_distance(x, y, startx, starty) > range) {
	instance_destroy(self);
}

speed = movSpeed;