///@func gameLoss(win)
///@desc Game loss process
///@arg win Bool if player won
function gameEnd(win = false) {
	with(oUI) {
		victory = win;
		pauseToggle("game end");
	}
}



///@func pauseToggle()
///@desc Toggle the game pause
///@arg menu Pause menu to display
function pauseToggle(menu = "default") {
	global.pause = !global.pause;
	
	with(all) {
		if(!object_index == oEnemySpawner) {
			//i should be the highest number of alarms any object has
			for(var i = 0; i < 6; i++) {
				if(global.pause) {
					alarmPauseTime[i] = alarm[i];	
					alarm[i] = -1;
				} else {
					alarm[i] = alarmPauseTime[i];
				}
			}
		}
	}
	
	oUI.state = menu;
}

///@func playerFaceDirection(xx, yy)
///@desc Make the player face the appropriate direction
///@arg xx Value of X movement
///@arg yy Value of Y movement
function playerFaceDirection(xx, yy) {
	if(xx < 0) {
		if(yy < 0) {
			image_angle = 135;
		} else if(yy == 0) {
			image_angle = 180;
		} else if(yy > 0) {
			image_angle = 225;
		}
	} else if(xx == 0) {
		if(yy < 0) {
			image_angle = 90;
		} else if(yy == 0) {
			image_angle = 0;
		} else if(yy > 0) {
			image_angle = 270;
		}
	} else if(xx > 0) {
		if(yy < 0) {
			image_angle = 45;
		} else if(yy == 0) {
			image_angle = 0;
		} else if(yy > 0) {
			image_angle = 315;
		}
	}
}

///@func dealDamage(target, damage)
///@desc Deal damage to target
///@arg target Target taking the damage
///@arg damage Magnitude of damage
function dealDamage(target, damage) {
	if(object_is_ancestor(target.object_index, oEnemy)) {
		var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), "Crit");
		if(global.playerUpgrades[# upgradesColumns.currentTier, row]) {
			if(rollChance(oPlayer.critChance)) { damage *= 2; }
		}
		
		var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), "Weaken");
		if(global.playerUpgrades[# upgradesColumns.currentTier, row]) {
			if(target.weakened) { damage *= 1.2; }
		}
	}
	
	target.currentHP -= damage;
}

///@func generateEnemySpawn(quad)
///@desc Pick spawn coordinates for enemy
///@arg quad Quadrant of screen to spawn in 0 - top, 1 - right, 2 - down, 3 - left 
function generateEnemySpawn(quad) {
	var vWidth = camera_get_view_width(view_camera[0]);
	var vHeight = camera_get_view_height(view_camera[0]);
	var camx = camera_get_view_x(view_camera[0]);
	var camy = camera_get_view_y(view_camera[0]);
	var offset = 10;

	var xx, yy;

	switch(quad) {
		case 0:
			xx = random(vWidth) + camx;
			yy = camy - offset;
			break;
		case 1:
			xx = camx + vWidth + offset;
			yy = random(vHeight) + camy;
			break;
		case 2:
			xx = random(vWidth) + camx;
			yy = camy + vHeight + offset;
			break;
		case 3:
			xx = camx - offset;
			yy = random(vHeight) + camy;
			break;
	}
	
	return [xx, yy];
}