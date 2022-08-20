/// @desc

randomize();

//Initialize sound group volume values
global.mainVol = 1;
global.musicVol = 1;
global.effectsVol = 1;

global.maxChoices = 4;

enum upgradesColumns {
	name,
	description,
	count
}

//Initialize upgrades
global.upgrades = createGrid(
	["Strength", "Increase base damage of attack"],
	["Speed", "Increase speed of attack"],
	["Infection", "Apply infection with attacks"],
	["Infestation", "Enemies explode into spores"]
);

global.availableUpgrades = ds_list_create();

for(var i = 0; i < ds_grid_height(global.upgrades); i++) {
	ds_list_add(global.availableUpgrades, global.upgrades[# upgradesColumns.name, i]);
}