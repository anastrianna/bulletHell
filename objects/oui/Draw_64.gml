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
			
			var upgradeText = global.upgrades[# upgradesColumns.name, row];
			if(global.upgrades[# upgradesColumns.maxTier, row] > 1) { upgradeText = fixUpgradeName(upgradeText, global.upgrades[# upgradesColumns.currentTier, row]); }
			draw_text(startx+(upgradeBoxWidth/2), starty+(upgradeBoxHeight/2), upgradeText);
			
			startx += xBuffer;
		}
		
		//Draw upgrade confirm button
		if(upgradeChoice != -1) {
			var confirmBoxWidth = vWidth/7;
			var confirmBoxHeight = vHeight/10;
			startx = (vWidth - confirmBoxWidth)/2;
			starty = vHeight - ((vHeight - upgradeBoxHeight)/2) + confirmBoxHeight/2;
			
			rectangleWithOutline(startx, starty, startx+confirmBoxWidth, starty+confirmBoxHeight, c_red, c_grey);
			draw_text(startx+(confirmBoxWidth/2), starty+(confirmBoxHeight/2), "Confirm");
		}
		
		break;
	case "mutation":
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
			
			var upgradeText = upgradeList[| i];
			
			draw_text(startx+(upgradeBoxWidth/2), starty+(upgradeBoxHeight/2), upgradeText);
			
			startx += xBuffer;
		}
		
		//Draw upgrade confirm button
		if(upgradeChoice != -1) {
			var confirmBoxWidth = vWidth/7;
			var confirmBoxHeight = vHeight/10;
			startx = (vWidth - confirmBoxWidth)/2;
			starty = vHeight - ((vHeight - upgradeBoxHeight)/2) + confirmBoxHeight/2;
			
			rectangleWithOutline(startx, starty, startx+confirmBoxWidth, starty+confirmBoxHeight, c_red, c_grey);
			draw_text(startx+(confirmBoxWidth/2), starty+(confirmBoxHeight/2), "Confirm");
		}
		break;
	case "game loss":
		c = c_white;
		startx = vWidth * 0.1;
		starty = vHeight * 0.1;
		var menuWidth = vWidth - startx*2;
		var menuHeight = vHeight - starty*2;
		
		draw_rectangle_color(startx, starty, startx + menuWidth, starty + menuHeight, c, c, c, c, true);
		draw_set_alpha(0.5);
		draw_rectangle_color(startx, starty, startx + menuWidth, starty + menuHeight, c, c, c, c, false);
		draw_set_alpha(1);
		
		draw_set_font(fLoss);
		var failureText = "Loss";
		startx = vWidth/2;
		starty += 10 + string_height(failureText);
		
		draw_text(startx, starty, failureText);
		
		draw_set_font(fMenus);
		var total = 0;
		var value;
		starty += 10 + string_height(failureText);
		value = kills * global.enemyValues[? "enemy"];
		total += value;
		
		var killString = "Enemies killed: " + string(kills) + " x " + string(global.enemyValues[? "enemy"]) + " = " + string(value);
		draw_text(startx, starty, killString);
		
		starty += 10 + string_height(killString);
		value = bossKills * global.enemyValues[? "boss"];
		total += value;
		
		killString = "Bosses killed: " + string(bossKills) + " x " + string(global.enemyValues[? "boss"]) + " = " + string(value);
		draw_text(startx, starty, killString);
		
		starty += 10 + string_height(killString);
		
		draw_text(startx, starty, "Total: " + string(value));
		
		totalValue = total;
		
		//Button to go back to main menu
		var buttonWidth = 128;
		var buttonHeight = 64;
		startx = (vWidth - buttonWidth)/2;
		starty = (vHeight - menuHeight)/2 + menuHeight - (10 + buttonHeight);
		c = c_white;
		var cc = c_grey;
		draw_set_font(fMenus);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		if(point_in_rectangle(mouse_x, mouse_y, uiX(startx), uiY(starty), uiX(startx+buttonWidth), uiY(starty+buttonHeight))) { cc = c_red; }
		rectangleWithOutline(startx, starty, startx+buttonWidth, starty+buttonHeight, c, cc);
		draw_text(startx+(buttonWidth/2), starty+(buttonHeight/2), "BACK");
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
