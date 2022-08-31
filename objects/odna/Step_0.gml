/// @desc

switch(state) {
	case "acquiring":
		if(!instance_exists(oPlayer)) { exit; }
		
		direction = point_direction(x, y, oPlayer.x, oPlayer.y);
		speed = oPlayer.movSpeed + 2;
		break;
	case "default":
		speed = 0;
		
		if(instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < 50) { state = "acquiring"; }
		break;
}