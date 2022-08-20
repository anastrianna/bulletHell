/// @desc
speed = 0;

var temp = irandom(3);

if(temp == 0) {
	direction = point_direction(x, y, oPlayer.x, oPlayer.y);	
} else { direction = random(360); }

if(!slowed) {
	speed = movSpeed;
} else {
	if(alarm[0] < 0) { alarm[0] = room_speed * oPlayer.slowDuration; }
	
	speed = movSpeed*((100-oPlayer.slowPower)/100); 
}