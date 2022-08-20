///@func gameLoss()
///@desc Game loss process
function gameLoss() {
	room_goto(rMenu);	
}

///@func levelUpgrade()
///@desc Upgrade character upon level up
function levelUpgrade() {
	with(oUI) {
		ds_list_clear(upgradeList);
		var tempList = ds_list_create();
		ds_list_copy(tempList, global.availableUpgrades);
		
		var choiceCount = min(global.maxChoices, ds_list_size(tempList));
		for(var i = 0; i < choiceCount; i++) {
			var temp = irandom(ds_list_size(tempList)-1);
			ds_list_add(upgradeList, tempList[| temp]);
			ds_list_delete(tempList, temp);
		}
		
		pauseToggle("upgrade");
		
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