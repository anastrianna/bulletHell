//Draw Background
var vWidth = camera_get_view_width(view_camera[0]);
var vHeight = camera_get_view_height(view_camera[0]);
var centerx = vWidth/2;
var centery = vHeight/2;
	
if(houseUpgradesMenuBool) {
	var c = c_white;
	var cc = c_grey;
	var startx = vWidth * 0.1;
	var starty = vHeight * 0.1;
	var menuWidth = vWidth - 2*startx;
	var menuHeight = vHeight - 2*starty;
	var text = "Bills: ";
	if(oGame.bills != 0) { text += "-"; }
	
	rectangleWithOutline(startx, starty, startx + menuWidth, starty + menuHeight, c, cc);
	
	var xx = vWidth/2;
	var yy = starty + 20;
	draw_set_font(fMenus);
	draw_text_color(xx, yy, text + string(oGame.bills), c, c, c, c, 1);
	
	if(houseUpgradePendingBool) {
		yy += 20;
		c = c_green;
		draw_text_color(xx, yy, "+" + string(houseUpgradeCosts), c, c, c, c, 1);
		
		var buttonWidth = 64;
		var buttonHeight = 32;
		xx = startx + menuWidth - buttonWidth;
		yy = starty + menuHeight - buttonHeight;
		c = c_white;
		cc = c_grey;
		
		rectangleWithOutline(xx, yy, xx+buttonWidth, yy+buttonHeight, c, cc);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fMenus);
		draw_text(xx+(buttonWidth/2), yy+(buttonHeight/2), "CONFIRM");
	}

	for(var i = 0; i < ds_grid_height(oGame.houseUpgrades); i++) {
		var requirements = oGame.houseUpgrades[# houseUpgradeCols.requirements, i];
		xx = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][0];
		yy = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][1];
		
		c = c_red;
		if(array_length_1d(requirements)) {
			for(var j = 0; j < array_length_1d(requirements); j++) {
				var reqRow = ds_grid_value_y(oGame.houseUpgrades, houseUpgradeCols.name, 0, houseUpgradeCols.name, ds_grid_height(oGame.houseUpgrades), requirements[j]);
				var reqx = oGame.houseUpgrades[# houseUpgradeCols.coordinates, reqRow][0];
				var reqy = oGame.houseUpgrades[# houseUpgradeCols.coordinates, reqRow][1];
				
				if(oGame.houseUpgrades[# houseUpgradeCols.active, reqRow]) { c = c_white; }
				draw_line_width_color(centerx + xx, centery + yy, centerx + reqx, centery + reqy, 10, c, c);
			}
		}
	}
	
	for(var i = 0; i < ds_grid_height(oGame.houseUpgrades); i++) {
		xx = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][0];
		yy = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][1];
		var requirements = oGame.houseUpgrades[# houseUpgradeCols.requirements, i];
		var sprite = oGame.houseUpgrades[# houseUpgradeCols.sprite, i];
		var name = oGame.houseUpgrades[# houseUpgradeCols.name, i];
		var active = oGame.houseUpgrades[# houseUpgradeCols.active, i];
		var cost = oGame.houseUpgrades[# houseUpgradeCols.cost, i];
		var spriteIndex = 0;
		
		if(active) {
			spriteIndex = 2;	
		} else if(oGame.bills >= cost) {
			var temp = true;
			if(array_length_1d(requirements)) {
				for(var j = 0; j < array_length_1d(requirements); j++) {
					var reqRow = ds_grid_value_y(oGame.houseUpgrades, houseUpgradeCols.name, 0, houseUpgradeCols.name, ds_grid_height(oGame.houseUpgrades), requirements[j]);
				
					if(!oGame.houseUpgrades[# houseUpgradeCols.active, reqRow]) { temp = false; }
				}	
			}
			
			if(temp) { spriteIndex = 1; }
		}
		
		draw_sprite(sprite, spriteIndex, centerx + xx, centery + yy);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fHouseUpgrade);
		draw_text(centerx + xx, centery + yy, name);
	}
	
	//Draw descriptions on hover-over
	for(var i = 0; i < ds_grid_height(oGame.houseUpgrades); i++) {
		xx = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][0];
		yy = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][1];	
		var desc = oGame.houseUpgrades[# houseUpgradeCols.description, i];
		var sDimensions = sprite_get_width(oGame.houseUpgrades[# houseUpgradeCols.sprite, i]);
		
		if(point_in_rectangle(mouse_x, mouse_y, uiX(xx - sDimensions/2), uiY(yy - sDimensions/2), uiX(xx + sDimensions/2), uiY(yy + sDimensions/2))) {
			var cost = oGame.houseUpgrades[# houseUpgradeCols.cost, i];
			desc += "\nCost: " + string(cost);
			var startx = mouse_x  - camera_get_view_x(view_camera[0]);
			var starty = mouse_y  - camera_get_view_y(view_camera[0]);
			createTipTextbox(startx, starty, desc);	
		}
	}
} else {
	var c = c_black;
	draw_rectangle_color(0, 0, vWidth, vHeight, c, c, c, c, false);

	var dsGrid = menuPages[page], dsHeight = ds_grid_height(dsGrid);
	var yBuffer = 32, xBuffer = 16, padding = 4;
	var starty = (vHeight/2) - ((dsHeight-1)/2*yBuffer), startx = vWidth/2;

	//Draw button elements
	draw_set_font(fMenus);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);

	var ltx = startx - xBuffer, lty, xo;
	var yy = 0;
	if (page >= settingsStart && page <= settingsEnd) {
		draw_set_halign(fa_right);
		repeat (dsHeight) {
			lty = starty + (yy*yBuffer);
			c = c_white;
			xo = 0;
	
			if (yy == menuOption[page]) {
				c = c_red;
				xo = -(xBuffer/2);
			}
	
			draw_text_color(ltx+xo, lty, dsGrid[# 0, yy], c, c, c, c, 1);
			yy++;
		}
		draw_line(startx, starty - yBuffer, startx, lty+yBuffer);
	}
	else {
		repeat (dsHeight) {
			lty = starty + (yy*yBuffer);
			c = c_white;
	
			if (yy == menuOption[page]) {
				c = c_red;
			}
	
			draw_rectangle_color(ltx-vWidth*.2, lty-yBuffer/2+padding, ltx+vWidth*.2, lty+yBuffer/2-padding, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
			draw_text_color(ltx, lty, dsGrid[# 0, yy], c, c, c, c, 1);
			yy++;
		}
	}

	//Draw setting elements
	draw_set_halign(fa_left);

	var rtx = startx + xBuffer, rty;

	yy = 0;
	repeat (dsHeight) {
		rty = starty + (yy*yBuffer);
		switch	(dsGrid[# 1, yy]) {
			case menuElementType.shift:
				var currentVal = dsGrid[# 3, yy];
				var currentArray = dsGrid[# 4, yy];
				var leftShift = "<< ", rightShift = " >>";
			
				if (currentVal == 0) leftShift = "";
				if (currentVal == array_length_1d(currentArray)-1) rightShift = "";
				c = c_white;
			
				if (yy == menuOption[page]) { c = c_yellow; }
				draw_text_color(rtx, rty, leftShift + currentArray[currentVal] + rightShift, c, c, c, c, 1);
				break;
			case menuElementType.slider:
				var len = 64;
				var currentVal = dsGrid[# 3, yy];
				var currentArray = dsGrid[# 4, yy];
				var circlePos = ((currentVal - currentArray[0]) / (currentArray[1] - currentArray[0]));
				c = c_white;
			
				draw_line_width(rtx, rty, rtx + len, rty, 2);
				if (yy == menuOption[page]) { c = c_yellow; }
				draw_circle_color(rtx + (circlePos*len), rty, 4, c, c, false);
				draw_text_color(rtx + (len*1.2), rty, string(floor(circlePos*100)) + "%", c, c, c, c, 1);
				break;
			case menuElementType.toggle:
				var currentVal = dsGrid[# 3, yy];
				var c1, c2;
				c = c_white;
				if (yy == menuOption[page]) { c = c_yellow; }
			
				if (currentVal == 0) { c1 = c; c2 = c_dkgray; }
				else { c1 = c_dkgray; c2 = c; }
			
				draw_text_color(rtx, rty, "ON", c1, c1, c1, c1, 1);
				draw_text_color(rtx + 32, rty, "OFF", c2, c2, c2, c2, 1);
				break;
			case menuElementType.input:
				var currentVal = dsGrid[# 3, yy];
				var stringVal;
			
				switch (currentVal) {
					case vk_up: stringVal = "UP KEY"; break;
					case vk_down: stringVal = "DOWN KEY"; break;
					case vk_left: stringVal = "LEFT KEY"; break;
					case vk_right: stringVal = "RIGHT KEY"; break;
					default: stringVal = chr(currentVal); break;
				}
			
				c = c_white;
				if (inputting && yy = menuOption[page]) { c = c_yellow; }

				draw_text_color(rtx, rty, stringVal, c, c, c, c, 1);
				break;
			case menuElementType.textInput:
				var len = vWidth*0.35;
				var height = 32;
				var cc = c_black;
				var textValue = "";
				c = c_gray;
			
				if(yy == menuOption[page]) {
					if(inputting) {
						c = c_white;
						textValue = helpfulString;
					} else {
						textValue = dsGrid[# 2, menuOption[page]];
					}
				} else { textValue = dsGrid[# 2, yy]; }
			
				draw_rectangle_color(rtx, rty-(height/2), rtx+len, rty+(height/2), c, c, c, c, true);
				draw_rectangle_color(rtx, rty-(height/2), rtx+len, rty+(height/2), cc, cc, cc, cc, false);
				draw_text(rtx, rty, textValue);
			
				break;
		}
		yy++;
	}
}