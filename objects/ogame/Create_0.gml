/// @desc

randomize();

saveData = ds_map_create();
fileName = "SaveData.key";

if(file_exists(fileName)) {
	saveData = ds_map_secure_load(fileName);
}

//Initialize sound group volume values
global.mainVol = 1;
global.musicVol = 1;
global.effectsVol = 1;

playerUnit = oPlayer;

global.enemyValues = ds_map_create();
ds_map_add(global.enemyValues, "enemy", 1);
ds_map_add(global.enemyValues, "boss", 100);

bills = 0;

var temp = ds_map_find_value(saveData, "bills");
if(!is_undefined(temp)) {
	bills = temp;
}

enum houseUpgradeCols {
	name,
	description,
	sprite,
	requirements,
	cost,
	coordinates,
	active,
	count
}

//Skill coordinates from center
houseUpgrades = createGrid(
	["HEATING", "AS THEY CUT COSTS ON HEATING, THE TEMPERATURE GOES DOWN.  A PERFECT ENVIRONMENT, DON'T YOU THINK?\n\n+2 to max health", sHouseUpgrade, [], 10, [0, 0], 0],
	["TAINTED WATER", "WHEN TIMES ARE HARD, THE SINK WILL HAVE TO DO.  BUT WHO KNOWS WHAT'S IN THOSE PIPES..\n\n+50 to range", sHouseUpgrade, ["HEATING"], 100, [-100, 0], 0],
	["BLOOD IN THE WATER", "I LOVE THE NEW PENNY FLAVOR FROM THE TAP.\n\nUnlock HIV", sHouseUpgrade, ["TAINTED WATER"], 500, [-200, 0], 0],
	["BUSTED PLUMBING", "NO TOILET.  GUESS THEY'LL HAVE TO IMPROVISE.\n\n1.5 x base damage", sHouseUpgrade, ["HEATING"], 100, [0, -100], 0],
	["TRASH BUILDUP", "THERE USED TO BE A GUY THAT TOOK CARE OF THIS.  I'M SURE THEY'LL GET TO IT SOON\n\n+1 bonus projectiles", sHouseUpgrade, ["HEATING"], 100, [100, 0], 0],
	["CHEMICAL WASTE", "HOW DID THIS EVEN GET HERE?  MUST BE THAT NEW ROOMMATE.\n\nUnlock Cancer", sHouseUpgrade, ["TRASH BUILDUP"], 500, [200, 0], 0]
);

//Initialize house upgrades from save
for(var i = 0; i < ds_grid_height(houseUpgrades); i++) {
	var temp = ds_map_find_value(oGame.saveData, houseUpgrades[# houseUpgradeCols.name, i]);
	if(!is_undefined(temp)) {
		houseUpgrades[# houseUpgradeCols.active, i] = temp;
	}
}