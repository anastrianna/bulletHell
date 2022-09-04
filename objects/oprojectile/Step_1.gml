///@descs

if(global.pause || is_undefined(startx) || is_undefined(starty) || is_undefined(dir)) { exit; }

if(point_distance(x, y, startx, starty) > range) {
	instance_destroy(self);
}

x += lengthdir_x(movSpeed, dir);
y += lengthdir_y(movSpeed, dir);