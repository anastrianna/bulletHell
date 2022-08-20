/// @desc Draw all UI elements to screen

var vWidth = camera_get_view_width(view_camera[0]);
var vHeight = camera_get_view_height(view_camera[0]);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
switch(state) {
	case "upgrade":
		//Draw upgrade choices
		var choiceCount = ds_list_size(upgradeList);
		var upgradeBoxWidth = vWidth/6;
		var upgradeBoxHeight = vHeight/2;
		var xBuffer = vWidth/(choiceCount+1);
		var startx = xBuffer - upgradeBoxWidth/2;
		var starty = (vHeight - upgradeBoxHeight)/2;

		for(var i = 0; i < choiceCount; i++) {
			var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), upgradeList[| i]);
			
			var c = c_red;
			//If choice is selected, highlight
			if(i == upgradeChoice) { c = c_white; }
			
			rectangleWithOutline(startx, starty, startx+upgradeBoxWidth, starty+upgradeBoxHeight, c, c_grey);
			draw_text(startx+(upgradeBoxWidth/2), starty+(upgradeBoxHeight/2), global.upgrades[# 0, row]);
			
			startx += xBuffer;
		}
		
		if(upgradeChoice != -1) {
			var confirmBoxWidth = vWidth/7;
			var confirmBoxHeight = vHeight/10;
			startx = (vWidth - confirmBoxWidth)/2;
			starty = vHeight - ((vHeight - upgradeBoxHeight)/2) + confirmBoxHeight/2;
			
			rectangleWithOutline(startx, starty, startx+confirmBoxWidth, starty+confirmBoxHeight, c_red, c_grey);
			draw_text(startx+(confirmBoxWidth/2), starty+(confirmBoxHeight/2), "Confirm");
		}
		
		break;
	case "default":
		//Draw timer
		if(instance_exists(oEnemySpawner)) {
			draw_text(vWidth/2, 30, string(oEnemySpawner.minutes) + ":" + string(oEnemySpawner.alarm[1]/room_speed));
		}

		//Draw character HP
		if(instance_exists(oPlayer)) {
			draw_text(vWidth/2, 60, "Health: " + string(oPlayer.currentHP) + "/" + string(oPlayer.maxHP));
	
			draw_text(vWidth/2, 90, "Exp: " + string(oPlayer.experience));
		}
		break;
}
