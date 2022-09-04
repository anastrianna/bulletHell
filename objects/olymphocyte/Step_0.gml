/// @desc

if(global.pause || !instance_exists(oPlayer)) { exit; }

if(infectedTime && alarm[1] < 0) { alarm[1] = room_speed * tickRate; }

switch(state) {
	case "move":				
		var movement, dir;
		
		/// @desc Movement
		var temp = irandom(1);

		if(temp) {
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
		
		if(point_distance(x, y, oPlayer.x, oPlayer.y) <= range) {
			state = "attack";
		}
		break;
	case "attack":
		if(alarm[3] < 0) { alarm[3] = room_speed * baseAtkSpeed; }
		break;
}