/// @desc

if(pause) {
	var vWidth = camera_get_view_width(view_camera[0]);
	var vHeight = camera_get_view_height(view_camera[0]);
	
	getInput();
	
	switch(state) {	
		case "upgrade":
			if(inspectButton) {
				var choiceCount = ds_list_size(upgradeList);
				var upgradeBoxWidth = vWidth/6;
				var upgradeBoxHeight = vHeight/2;
				var xBuffer = vWidth/(choiceCount+1);
				var startx = uiX(xBuffer - upgradeBoxWidth/2);
				var starty = uiY((vHeight - upgradeBoxHeight)/2);

				for(var i = 0; i < choiceCount; i++) {		
					if(point_in_rectangle(mouse_x, mouse_y, startx, starty, startx+upgradeBoxWidth, starty+upgradeBoxHeight)) {
						upgradeChoice = i;
					}
			
					startx += xBuffer;
				}
				
				if(upgradeChoice != -1) {
					var confirmBoxWidth = vWidth/7;
					var confirmBoxHeight = vHeight/10;
					startx = uiX((vWidth - confirmBoxWidth)/2);
					starty = uiY(vHeight - ((vHeight - upgradeBoxHeight)/2) + confirmBoxHeight/2);
			
					if(point_in_rectangle(mouse_x, mouse_y, startx, starty, startx+confirmBoxWidth, starty+confirmBoxHeight)) {
						pauseToggle();
						
						var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), upgradeList[| upgradeChoice]);
						
						applyUpgrade(global.upgrades[# 0, row]);
					}
				}
			}
			break;
		case "mutation":
			if(inspectButton) {
				var choiceCount = ds_list_size(upgradeList);
				var upgradeBoxWidth = vWidth/6;
				var upgradeBoxHeight = vHeight/2;
				var xBuffer = vWidth/(choiceCount+1);
				var startx = uiX(xBuffer - upgradeBoxWidth/2);
				var starty = uiY((vHeight - upgradeBoxHeight)/2);

				for(var i = 0; i < choiceCount; i++) {		
					if(point_in_rectangle(mouse_x, mouse_y, startx, starty, startx+upgradeBoxWidth, starty+upgradeBoxHeight)) {
						upgradeChoice = i;
					}
			
					startx += xBuffer;
				}
				
				if(upgradeChoice != -1) {
					var confirmBoxWidth = vWidth/7;
					var confirmBoxHeight = vHeight/10;
					startx = uiX((vWidth - confirmBoxWidth)/2);
					starty = uiY(vHeight - ((vHeight - upgradeBoxHeight)/2) + confirmBoxHeight/2);
			
					if(point_in_rectangle(mouse_x, mouse_y, startx, starty, startx+confirmBoxWidth, starty+confirmBoxHeight)) {
						pauseToggle();
						
						applyMutation(upgradeList[| upgradeChoice]);
					}
				}
			}
			break;
		case "game loss":
			if(inspectButton) {
				var menuHeight = vHeight - vHeight*0.2;
				var buttonWidth = 128;
				var buttonHeight = 64;
				startx = (vWidth - buttonWidth)/2;
				starty = (vHeight - menuHeight)/2 + menuHeight - (10 + buttonHeight);
		
				if(point_in_rectangle(mouse_x, mouse_y, uiX(startx), uiY(starty), uiX(startx+buttonWidth), uiY(starty+buttonHeight))) { 
					oUI.pauseSurface = -1;
					oUI.pause = false;
					oUI.state = "default";
					oUI.player = -1;
		
					instance_activate_all();
					
					var currentBills = oGame.bills;
					var newBills = totalValue;
					if(!is_undefined(currentBills)) {
						newBills += currentBills;
					}
					ds_map_replace(oGame.saveData, "bills", newBills);
					ds_map_secure_save(oGame.saveData, oGame.fileName);
					oGame.bills = newBills;
					room_goto(rMenu); 
				}
			}
			break;
		case "default":
			break;
	}
}