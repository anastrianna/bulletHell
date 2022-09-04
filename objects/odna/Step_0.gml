/// @desc

if(global.pause) { exit; }

switch(state) {
	case "acquiring":
		if(!instance_exists(oPlayer)) { exit; }
		
		var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
		var movement = oPlayer.movSpeed + 2;
		
		x += lengthdir_x(movement, dir);
		y += lengthdir_y(movement, dir);
		break;
	case "default":
		if(instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < 50) { state = "acquiring"; }
		break;
}