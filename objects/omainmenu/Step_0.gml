//script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);
var vWidth = camera_get_view_width(view_camera[0]);
var vHeight = camera_get_view_height(view_camera[0]);
var centerx = vWidth/2;
var centery = vHeight/2;

getInput();

if(houseUpgradesMenuBool) {
	if(inspectButton) {
		if(houseUpgradePendingBool) {
			var startx = vWidth * 0.1;
			var starty = vHeight * 0.1;
			var menuWidth = vWidth - 2*startx;
			var menuHeight = vHeight - 2*starty;
			var buttonWidth = 80;
			var buttonHeight = 50;
			xx = startx + menuWidth - buttonWidth;
			yy = starty + menuHeight - buttonHeight;
		
			if(point_in_rectangle(mouse_x, mouse_y, uiX(xx), uiY(yy), uiX(xx+buttonWidth), uiY(yy+buttonHeight))) {
				oGame.bills -= houseUpgradeCosts;
				ds_map_replace(oGame.saveData, "bills", oGame.bills);
				
				for(var i = 0; i < ds_grid_height(oGame.houseUpgrades); i++) {
					var name = oGame.houseUpgrades[# houseUpgradeCols.name, i];
					var active = oGame.houseUpgrades[# houseUpgradeCols.active, i];
					
					ds_map_replace(oGame.saveData, name, active);	
				}
				ds_map_secure_save(oGame.saveData, oGame.fileName);
				
				houseUpgradePendingBool = false;
				houseUpgradeCosts = 0;
				houseUpgradesMenuBool = false;
			}
		}
		for(var i = 0; i < ds_grid_height(oGame.houseUpgrades); i++) {
			var name = oGame.houseUpgrades[# houseUpgradeCols.name, i];
			var temp = ds_map_find_value(oGame.saveData, name);
			if(!is_undefined(temp)) { 
				if(temp) { continue; }	
			}
			
			var xx = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][0];
			var yy = oGame.houseUpgrades[# houseUpgradeCols.coordinates, i][1];
			var sDimensions = sprite_get_width(oGame.houseUpgrades[# houseUpgradeCols.sprite, i]);
			var cost = oGame.houseUpgrades[# houseUpgradeCols.cost, i];
			var balance = oGame.bills - houseUpgradeCosts;
			
			if(balance >= cost && point_in_rectangle(mouse_x, mouse_y, uiX(centerx + xx - sDimensions/2), uiY(centery + yy - sDimensions/2), uiX(centerx + xx + sDimensions/2), uiY(centery + yy + sDimensions/2))) {
				var requirements = oGame.houseUpgrades[# houseUpgradeCols.requirements, i];
				
				var temp = true;
				if(array_length_1d(requirements)) {
					for(var j = 0; j < array_length_1d(requirements); j++) {
						var reqRow = ds_grid_value_y(oGame.houseUpgrades, houseUpgradeCols.name, 0, houseUpgradeCols.name, ds_grid_height(oGame.houseUpgrades), requirements[j]);
				
						if(!oGame.houseUpgrades[# houseUpgradeCols.active, reqRow]) { temp = false; }
					}
				}
				
				if(temp) {
					var active = oGame.houseUpgrades[# houseUpgradeCols.active, i];
					
					if(active) {
						oGame.houseUpgrades[# houseUpgradeCols.active, i] = 0;
						houseUpgradeCosts -= cost;
						if(!houseUpgradeCosts) { houseUpgradePendingBool = false; }
					} else {
						oGame.houseUpgrades[# houseUpgradeCols.active, i] = 1;
						houseUpgradeCosts += cost;
						houseUpgradePendingBool = true;
					}					
				}
			}
		}
	}
	if(cancel) {
		for(var i = 0; i < ds_grid_height(oGame.houseUpgrades); i++) {
			var name = oGame.houseUpgrades[# houseUpgradeCols.name, i];
			var active = ds_map_find_value(oGame.saveData, name);
			
			if(!is_undefined(active)) {
				oGame.houseUpgrades[# houseUpgradeCols.active, i] = active;		
			} else { oGame.houseUpgrades[# houseUpgradeCols.active, i] = 0; }
		}
				
		houseUpgradePendingBool = false;
		houseUpgradeCosts = 0;
		houseUpgradesMenuBool = false;		
	}
} else {
	var dsGrid = menuPages[page], dsHeight = ds_grid_height(dsGrid);

	switch(dsGrid[# 1, menuOption[page]]){
		case menuElementType.shift:
			var hInput = menuHMov;
			dsGrid[# 3, menuOption[page]] += hInput;
			dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], 0, array_length_1d(dsGrid[# 4, menuOption[page]]) - 1);
			script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 4, menuOption[page]][dsGrid[# 3, menuOption[page]]]);
			break;
		case menuElementType.slider:
			var hInput = menuHMov;
			var currentArray = dsGrid[# 4, menuOption[page]]
			dsGrid[# 3, menuOption[page]] += hInput*.01;
			dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], currentArray[0], currentArray[1]);
			script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);
			break;
		case menuElementType.toggle:
			var hInput = menuHMov;
			dsGrid[# 3, menuOption[page]] += hInput;
			dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], 0, 1);
			script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);
			break;
		case menuElementType.input:
			if (inputting) {
				var key = keyboard_lastkey;
				if (key != vk_enter) {
					dsGrid[# 3, menuOption[page]] = key;
					//Need to rework input
				}
			}
			break;
		case menuElementType.textInput:
			var maxLength = dsGrid[# 3, menuOption[page]]
			if (inputting) {
				if(string_length(helpfulString) < maxLength) {
					helpfulString = keyboard_string;
				} else if(back) {
					helpfulString = string_delete(helpfulString, maxLength, 1);
					keyboard_string = helpfulString;
				}
			} else { keyboard_string = ""; }
			break;
	}
	if (!inputting) {
		var oChange = menuVMov;
		menuOption[page] += oChange;
		if (menuOption[page] < 0) menuOption[page] = dsHeight-1;
		if (menuOption[page] > dsHeight-1) menuOption[page] = 0;

		if (menuOption[page] != lastButton) {
			//part_particles_create(particleEffects, menux, menuy + (buttonh+buttonPadding)*menuIndex, boxFlash, 1);
			audio_play_sound(soMenu, 1, false);
		}
		lastButton = menuOption[page];
	}

	if (select) {
		switch(dsGrid[# 1, menuOption[page]]){
			case menuElementType.scriptRunner: 
				if(dsGrid[# 3, menuOption[page]] == false) {
					script_execute(dsGrid[# 2, menuOption[page]]); 
				} else { script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]); }
				break;
			case menuElementType.pageTransfer: page = dsGrid[# 2, menuOption[page]]; break;
			case menuElementType.input: inputting = !inputting; break;
			case menuElementType.textInput:
				if(inputting) {
					//Set lobby name to chosen name
					dsGrid[# 2, menuOption[page]] = helpfulString;
					helpfulString = "";
					inputting = !inputting;	
				} else {
					//Set input string to current lobby name
					keyboard_string = dsGrid[# 2, menuOption[page]];
					inputting = !inputting;	
				}
				break;
		}
	}
}