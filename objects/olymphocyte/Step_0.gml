/// @desc
event_inherited();

if(infectedTime > -1 && alarm[1] < 0) { alarm[1] = room_speed * 1; }

switch(state) {
	case "move":
		if(point_distance(x, y, oPlayer.x, oPlayer.y) <= range) {
			state = "attack";
		}
		
		/// @desc Movement
		var temp = irandom(1);

		if(temp) {
			direction = point_direction(x, y, oPlayer.x, oPlayer.y);	
		} else { direction = random(360); }

		if(!slowed) {
			speed = movSpeed;
		} else {
			if(alarm[0] < 0) { alarm[0] = room_speed * oPlayer.slowDuration; }
	
			speed = movSpeed*((100-oPlayer.slowPower)/100); 
		}
		break;
	case "attack":
		if(alarm[3] < 0) { alarm[3] = room_speed * baseAtkSpeed; }
		break;
}