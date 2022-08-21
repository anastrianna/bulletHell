///@func gameLoss()
///@desc Game loss process
function gameLoss() {
	room_goto(rMenu);	
}

///@func playerUpgrade()
///@desc Upgrade character upon level up or boss kill
///@arg state State for UI
function playerUpgrade(state) {
	with(oUI) {
		ds_list_clear(upgradeList);
		var tempList = ds_list_create();
		switch(state) {
			case "upgrade":
				ds_list_copy(tempList, global.availableUpgrades);

				var choiceCount = min(global.maxChoices, ds_list_size(tempList));
				for(var i = 0; i < choiceCount; i++) {
					var temp = irandom(ds_list_size(tempList)-1);
					ds_list_add(upgradeList, tempList[| temp]);
					ds_list_delete(tempList, temp);
				}
				break;
			case "mutation":
				var temp = irandom(ds_list_size(oPlayer.availableMutations)-1);
				
				ds_list_add(upgradeList, oPlayer.availableMutations[| temp]);
				ds_list_delete(oPlayer.availableMutations, temp);
				break;
		}
		
		pauseToggle(state);
		
		ds_list_destroy(tempList);
	}
}

///@func pauseToggle()
///@desc Toggle the game pause
///@arg menu Pause menu to display
function pauseToggle(menu = "default") {
	if(oUI.pause) {
		oUI.pauseSurface = -1;
		oUI.pause = false;
		oUI.state = "default";
		
		instance_activate_all();
	} else {
		if(!sprite_exists(oUI.pauseSurface)) {
			var surfacex = camera_get_view_x(view_camera[0]);
			var surfacey = camera_get_view_y(view_camera[0]);
			var surfacew = camera_get_view_width(view_camera[0]);
			var surfaceh = camera_get_view_height(view_camera[0]);
			oUI.pauseSurface = sprite_create_from_surface(application_surface, surfacex, surfacey, surfacew, surfaceh, 0, 0, surfacew/2, surfaceh/2);
		}
		oUI.pause = true;
		
		state = menu;
		instance_deactivate_all(true);
	}
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
		var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), "Crit");
		if(global.upgrades[# upgradesColumns.currentTier, row]) {
			if(rollChance(oPlayer.critChance)) { damage *= 2; }
		}
		
		var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), "Weaken");
		if(global.upgrades[# upgradesColumns.currentTier, row]) {
			if(target.weakened) { damage *= 1.2; }
		}
	}
	
	target.currentHP -= damage;
}