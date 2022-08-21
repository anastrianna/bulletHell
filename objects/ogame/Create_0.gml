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
	maxTier,
	currentTier,
	count
}

//Initialize upgrades
global.upgrades = createGrid(
	["Strength", "Increase base damage of attack", 5, 0],
	["Attack Speed", "Increase speed of attack", 3, 0],
	["Projectile Speed", "Increase speed of projectiles", 2, 0],
	["Health", "Increase maximum health", 2, 0],
	["Health Regen", "Gain health regeneration", 1, 0],
	["Infection", "Apply infection with attacks", 1, 0],
	["Infestation", "Enemies explode into spores", 1, 0],
	["Crit", "Crit chance", 1, 0],
	["Projectile Count", "Increase number of projectiles produced from", 3, 0],
	["Weaken", "Chance to debuff enemies to recieve more damage", 1, 0],
	["Movement Speed", "Increase player movement speed", 3, 0],
	["Effect Power", "Increase effect power", 2, 0]
);

global.availableUpgrades = ds_list_create();

for(var i = 0; i < ds_grid_height(global.upgrades); i++) {
	ds_list_add(global.availableUpgrades, global.upgrades[# upgradesColumns.name, i]);
}

playerUnit = oPlayer;