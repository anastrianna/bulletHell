/// @desc
speed = 0;

var temp = irandom(3);

if(temp == 0) {
	direction = point_direction(x, y, oPlayer.x, oPlayer.y);	
} else { direction = random(360); }

speed = movSpeed;