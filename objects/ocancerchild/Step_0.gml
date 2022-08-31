/// @desc
if(!instance_exists(oPlayer)) { exit; }
var movSpeed = oPlayer.projectileSpeed;

switch(state) {
	case "load":
		var dist = point_distance(x, y, oPlayer.x, oPlayer.y);
		var movement = oPlayer.movSpeed + 1;

		if(dist < movement) {
			x = oPlayer.x;
			y = oPlayer.y;
			if(target+1) {
				targetx = target.x;
				targety = target.y;
				direction = point_direction(x, y, targetx, targety);
				speed = oPlayer.projectileSpeed;
				state = "fire";
				oPlayer.loading = false;
			} else { state = "default"; }
		} else {
			direction = point_direction(x, y, oPlayer.x, oPlayer.y);
			speed = movement;
		}
		break;
	case "fire":
		if(point_distance(x, y, targetx, targety) < movSpeed) {
			alarm[0] = room_speed * 0.1; 
		}
		if(place_meeting(x, y, oEnemy)) {
			var enemy = instance_place(x, y, oEnemy);
			if(!(ds_list_find_index(hitTargets, enemy)+1)) {
				enemy.currentHP -= oPlayer.atkDamage;
				ds_list_add(hitTargets, enemy);
			}
		}
		break;
	case "reload":
		if(point_distance(x, y, oPlayer.x, oPlayer.y) < sprite_get_width(sPlayer.sprite_index)/2) {
			state = "default";
		} else {
			speed = oPlayer.movSpeed + oPlayer.atkSpeedBuff/15 + 1;
			direction = point_direction(x, y, oPlayer.x, oPlayer.y);
		}
		
		break;
	case "default":
		if(point_distance(x, y, targetx, targety) < sprite_get_width(sprite_index)/2) {
			x = targetx;
			y = targety;
		} else {
			speed = oPlayer.movSpeed + oPlayer.atkSpeedBuff/5;
			direction = point_direction(x, y, targetx, targety);
		}
		break;
}