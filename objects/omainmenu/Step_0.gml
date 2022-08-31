//script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);

getInput();

if(upgradesMenuBool) {
	if(cancel) { upgradesMenuBool = false; }
} else {
	var dsGrid = menuPages[page], dsHeight = ds_grid_height(dsGrid);

	switch(dsGrid[# 1, menuOption[page]]){
		case menuElementType.shift:
			var hInput = menuHMov;
			dsGrid[# 3, menuOption[page]] += hInput;
			dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], 0, array_length_1d(dsGrid[# 4, menuOption[page]]) - 1);
			script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);
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