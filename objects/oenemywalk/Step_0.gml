/// @desc

event_inherited();
if(global.pause || !instance_exists(oPlayer)) { exit; }

var vWidth = camera_get_view_width(view_camera[0]);

var temp = irandom(walkDelay);
var dir, movement;

if(!temp) {
	dir = point_direction(x, y, oPlayer.x, oPlayer.y);	
} else { dir = random(360); }

if(point_distance(x, y, oPlayer.x, oPlayer.y) > vWidth*2) {
	movement = movSpeed*2;
} else if(!slowed) {
	movement = movSpeed;
} else {
	if(alarm[0] < 0) { alarm[0] = room_speed * oPlayer.slowDuration; }
	
	movement = movSpeed*((100-oPlayer.slowPower)/100);
}

x += lengthdir_x(movement, dir);
y += lengthdir_y(movement, dir);