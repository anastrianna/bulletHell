/// @desc Movement
if(global.pause || !instance_exists(oPlayer)) { exit; }

var temp = irandom(3);

var dir, movement;

if(!temp) {
	dir = point_direction(x, y, oPlayer.x, oPlayer.y);	
} else { dir = random(360); }

if(!slowed) {
	movement = movSpeed;
} else {
	if(alarm[0] < 0) { alarm[0] = room_speed * oPlayer.slowDuration; }
	
	movement = movSpeed*((100-oPlayer.slowPower)/100);
}

x += lengthdir_x(movement, dir);
y += lengthdir_y(movement, dir);

if(infectedTime && alarm[1] < 0) { alarm[1] = room_speed * tickRate; }