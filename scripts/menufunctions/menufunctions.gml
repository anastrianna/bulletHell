///@func startGame()
///@desc Start game from main menu
function startGame() {
	room_goto(rGame);
}

///@func toggleUpgradeMenu()
///@desc Open/Close the upgrade menu
function toggleUpgradeMenu() {
	oMainMenu.houseUpgradesMenuBool = true;
}

///@func exitGame()
///@desc Close the game
function exitGame() {
	game_end();	
}

///@func changeVolume(value)
///@desc Change the volume of the given sound group
///@arg value Magnitude of change
function changeVolume(value) {
	var type = menuOption[page];

	switch (type) {
		case 0: audio_master_gain(value); break;
		case 1: audio_group_set_gain(agMusic, value, 0); break;
		case 2: audio_group_set_gain(agEffects, value, 0); break;
	}
}

///@func changeWindowMode(value)
///@desc Change mode of game window
///@arg value Boolean
function changeWindowMode(value) {
	switch (value) {
		case 0: window_set_fullscreen(true); break;
		case 1: window_set_fullscreen(false); break;
	}
}

///@func changePlayerUnit(name)
///@desc Change player unit
///@arg name Disease name
function changePlayerUnit(name) {
	switch(name) {
		case "INFLUENZA": oGame.playerUnit = oInfluenza; break;
		case "HIV": oGame.playerUnit = oHIV; break;
		case "CANCER": oGame.playerUnit = oCancer; break;
	}
}

///@func determinePlayableDiseases()
///@desc Populate playable disease
function determinePlayableDiseases() {
	oMainMenu.page = menuPage.start;
	
	var availableDiseases = ds_list_create();
	ds_list_add(availableDiseases, "INFLUENZA");
	
	var temp = ds_map_find_value(oGame.saveData, "BLOOD IN THE WATER");
	if(!is_undefined(temp) && temp) { ds_list_add(availableDiseases, "HIV"); }
	
	var temp = ds_map_find_value(oGame.saveData, "CHEMICAL WASTE");
	if(!is_undefined(temp) && temp) { ds_list_add(availableDiseases, "CANCER"); }
	
	var array = array_create(ds_list_size(availableDiseases));
	for(var i = 0; i < ds_list_size(availableDiseases); i++) {
		array[i] = availableDiseases[| i];
	}
	ds_list_destroy(availableDiseases);
	
	oMainMenu.dsGameStart[# 4, 0] = array;
}