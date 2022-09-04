/// @desc

if(global.pause || !instance_exists(oPlayer)) { exit; }
var movSpeed = oPlayer.projectileSpeed;
var reloadSpeed = oPlayer.movSpeed + oPlayer.atkSpeedBuff/15 + 1;

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
				
				dir = point_direction(x, y, targetx, targety);
				
				state = "fire";
			} else { state = "default"; }
		} else {
			dir = point_direction(x, y, oPlayer.x, oPlayer.y);

			x += lengthdir_x(movement, dir);
			y += lengthdir_y(movement, dir);
		}
		break;
	case "fire":
		//Possibly move this below point_distance to adjust how far child travels
		x += lengthdir_x(movSpeed, dir);
		y += lengthdir_y(movSpeed, dir);
		
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
			dir = point_direction(x, y, oPlayer.x, oPlayer.y);
			
			x += lengthdir_x(reloadSpeed, dir);
			y += lengthdir_y(reloadSpeed, dir);
		}
		
		break;
	case "default":
		if(point_distance(x, y, targetx, targety) < sprite_get_width(sprite_index)/2) {
			x = targetx;
			y = targety;
		} else {
			dir = point_direction(x, y, targetx, targety);
			
			x += lengthdir_x(reloadSpeed, dir);
			y += lengthdir_y(reloadSpeed, dir);
		}
		break;
}