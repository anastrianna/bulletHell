/// @desc Draw all UI elements to screen

var vWidth = camera_get_view_width(view_camera[0]);
var vHeight = camera_get_view_height(view_camera[0]);
var camx = camera_get_view_x(view_camera[0]);
var camy = camera_get_view_y(view_camera[0]);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fMenus);
//Draw general information around screen
if(instance_exists(oEnemySpawner)) {
	var timerText = timerNumberString(oEnemySpawner.minutes);
	timerText += ":" + timerNumberString(oEnemySpawner.alarm[1]/room_speed);
	
	draw_text(vWidth/2, 30,  timerText);
}

if(instance_exists(oPlayer)) {
	draw_text(vWidth/2, 60, "Health: " + string(oPlayer.currentHP) + "/" + string(oPlayer.maxHP));
	
	draw_text(vWidth/2, 90, "Exp: " + string(oPlayer.experience));
}

//Draw popup menus: upgrades/mutations and game end
switch(state) {
	case "pause":
		var startx = vWidth*0.1;
		var starty = vHeight*0.1;
		var menuWidth = vWidth - startx*2;
		var menuHeight = vHeight - starty*2;
		var padding = 10;
		var c = c_white;
		var cc = c_dkgray;
		
		rectangleWithOutline(startx, starty, startx + menuWidth, starty + menuHeight, c, cc);
		
		var xx = vWidth/2;
		var yy = vHeight/2;
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		var text = "";
		var i = 0;
		repeat(ds_list_size(global.activeUpgrades)) {
			var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), global.activeUpgrades[| i]);
			var upgradeText = global.playerUpgrades[# upgradesColumns.name, row];
			if(global.playerUpgrades[# upgradesColumns.maxTier, row] > 1) { upgradeText = fixUpgradeName(upgradeText, global.playerUpgrades[# upgradesColumns.currentTier, row]); }
			text += upgradeText;
			
			if(i < ds_list_size(global.activeUpgrades) - 1) { text += ", "; }
			
			i++;
		}
		draw_text_ext(xx, yy, text, -1, menuWidth - 2*padding);
		break;
	case "upgrade":
		//Draw upgrade choices
		var choiceCount = ds_list_size(upgradeList);
		var upgradeBoxWidth = vWidth/6;
		var upgradeBoxHeight = vHeight/2;
		var xBuffer = vWidth/(choiceCount+1);
		var startx = xBuffer - upgradeBoxWidth/2;
		var starty = (vHeight - upgradeBoxHeight)/2;
		var xx = startx;

		for(var i = 0; i < choiceCount; i++) {
			var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), upgradeList[| i]);
			
			var c = c_red;
			//If choice is selected, highlight
			if(i == upgradeChoice) { c = c_white; }
			
			rectangleWithOutline(xx, starty, xx+upgradeBoxWidth, starty+upgradeBoxHeight, c, c_grey);
			
			var upgradeText = global.playerUpgrades[# upgradesColumns.name, row];
			if(global.playerUpgrades[# upgradesColumns.maxTier, row] > 1) { upgradeText = fixUpgradeName(upgradeText, global.playerUpgrades[# upgradesColumns.currentTier, row] + 1); }
			draw_text(xx+(upgradeBoxWidth/2), starty+(upgradeBoxHeight/2), upgradeText);
			
			xx += xBuffer;
		}
		
		xx = startx;
		for(var i = 0; i < choiceCount; i++) {
			if(point_in_rectangle(mouse_x, mouse_y, uiX(xx), uiY(starty), uiX(xx+upgradeBoxWidth), uiY(starty+upgradeBoxHeight))) {
				var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), upgradeList[| i])
				var desc = global.playerUpgrades[# upgradesColumns.description, row];
				
				createTipTextbox(mouse_x - camx, mouse_y - camy, desc);
			}
			
			xx += xBuffer;
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
			var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), upgradeList[| i]);
			
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
	case "game end":
		c = c_white;
		startx = vWidth * 0.1;
		starty = vHeight * 0.1;
		var menuWidth = vWidth - startx*2;
		var menuHeight = vHeight - starty*2;
		
		draw_rectangle_color(startx, starty, startx + menuWidth, starty + menuHeight, c, c, c, c, true);
		draw_set_alpha(0.8);
		c = c_dkgray;
		draw_rectangle_color(startx, starty, startx + menuWidth, starty + menuHeight, c, c, c, c, false);
		draw_set_alpha(1);

		draw_set_font(fGameEnd);
		var gameEndText = "Loss";
		if(victory) { gameEndText = "Host Eliminated"; }
		startx = vWidth/2;
		starty += 10 + string_height(gameEndText);
		
		draw_text(startx, starty, gameEndText);
		
		var total = 0;
		var value;
		starty += 10;
		value = kills * global.enemyValues[? "enemy"];
		total += value;
		
		var receiptLeftString = "Enemies killed:";
		var receiptRightString = string(kills) + " x " + string(global.enemyValues[? "enemy"]) + " = " + string(value);
		
		value = bossKills * global.enemyValues[? "boss"];
		total += value;
		
		receiptLeftString += "\nBosses killed:";
		receiptRightString += "\n" + string(bossKills) + " x " + string(global.enemyValues[? "boss"]) + " = " + string(value);
		
		receiptLeftString += "\n\nTotal Charges:";
		receiptRightString += "\n\n" + string(total);
		
		var receiptWidth = vWidth * 0.3;
		startx -= receiptWidth/2;
		starty += string_height(gameEndText)/2;
		var receiptPadding = 10;
		draw_set_font(fMenus);
		var receiptHeight = string_height_ext(receiptLeftString, -1, receiptWidth) + 2*receiptPadding;
		c = c_white;
		draw_rectangle_color(startx, starty, startx + receiptWidth, starty + receiptHeight, c, c, c, c, false);
		
		startx += receiptPadding;
		starty += receiptPadding;
		
		draw_set_halign(fa_left); 
		draw_set_valign(fa_top);
		draw_set_color(c_black);
		draw_text(startx, starty, receiptLeftString);
		
		startx += receiptWidth - 2*receiptPadding;
		draw_set_halign(fa_right); 
		draw_text(startx, starty, receiptRightString);
		
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
		draw_set_color(c_white);
		draw_text(startx+(buttonWidth/2), starty+(buttonHeight/2), "BACK");
		break;
	case "default":
		break;
}
