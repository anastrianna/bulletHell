///@func startGame()
///@desc Start game from main menu
function startGame() {
	room_goto(rGame);
}

///@func toggleUpgradeMenu()
///@desc Open/Close the upgrade menu
function toggleUpgradeMenu() {
	oMainMenu.upgradesMenuBool = true;
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

///@func changePlayerUnit(value)
///@desc Change player unit
///@arg value Boolean
function changePlayerUnit(value) {
	switch(value) {
		case 0: oGame.playerUnit = oInfluenza; break;
		case 1: oGame.playerUnit = oHIV; break;
		case 2: oGame.playerUnit = oCancer; break;
	}
}