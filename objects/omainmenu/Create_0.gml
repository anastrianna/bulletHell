lastButton = 0;

enum menuPage {
	main,
	settings,
	start,
	audio,
	video,
	controls,
	height
}

dsMenuMain = createGrid(
	["PLAY", menuElementType.pageTransfer, menuPage.start, false], 
	["UPGRADES", menuElementType.scriptRunner, toggleUpgradeMenu, false],
	["SETTINGS", menuElementType.pageTransfer, menuPage.settings],
	["EXIT", menuElementType.scriptRunner, exitGame, false]
);

dsSettings = createGrid(
	["AUDIO", menuElementType.pageTransfer, menuPage.audio],
	["VIDEO", menuElementType.pageTransfer, menuPage.video],
	["CONTROLS", menuElementType.pageTransfer, menuPage.controls],
	["BACK", menuElementType.pageTransfer, menuPage.main]
);

dsGameStart = createGrid(
	["INFECTION", menuElementType.shift, changePlayerUnit, 0, ["INFLUENZA", "HIV"]],
	["CONFIRM", menuElementType.scriptRunner, startGame, false], 
);

dsMenuAudio = createGrid(
	["MASTER", menuElementType.slider, changeVolume, global.mainVol, [0, 1]],
	["MUSIC", menuElementType.slider, changeVolume, global.musicVol, [0, 1]],
	["SOUNDS", menuElementType.slider, changeVolume, global.effectsVol, [0, 1]],
	["BACK", menuElementType.pageTransfer, menuPage.settings]
);

dsMenuVideo = createGrid(
	["WINDOW MODE", menuElementType.toggle, changeWindowMode, 1, ["FULLSCREEN", "WINDOWED"]],
	["BACK", menuElementType.pageTransfer, menuPage.settings]
);

dsMenuControls = createGrid(
	["LEFT", menuElementType.input, "left", vk_left],
	["RIGHT", menuElementType.input, "right", vk_right],
	["BACK", menuElementType.pageTransfer, menuPage.settings]
);

page = 0;
menuPages = [dsMenuMain, dsSettings, dsGameStart, dsMenuAudio, dsMenuVideo, dsMenuControls];
settingsStart = 2;
settingsEnd = 5;

var i = 0, arrayLen = array_length_1d(menuPages);
repeat (arrayLen) {
	menuOption[i] = 0;
	i++;
}

helpfulString = "";

inputting = false;