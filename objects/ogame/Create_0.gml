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
	sprite,
	requirements,
	cost,
	coordinates,
	active,
	count
}

//Skill coordinates from center
houseUpgrades = createGrid(
	["HEATING", sHouseUpgrade, [], 10, [0, 0], 0],
	["TAINTED WATER", sHouseUpgrade, ["HEATING"], 100, [-100, 0], 0],
	["BLOOD IN THE WATER", sHouseUpgrade, ["TAINTED WATER"], 500, [-200, 0], 0],
	["BUSTED PLUMBING", sHouseUpgrade, ["HEATING"], 100, [0, -100], 0],
	["TRASH BUILDUP", sHouseUpgrade, ["HEATING"], 100, [100, 0], 0],
	["CHEMICAL WASTE", sHouseUpgrade, ["TRASH BUILDUP"], 500, [200, 0], 0]
);

//Initialize house upgrades from save
for(var i = 0; i < ds_grid_height(houseUpgrades); i++) {
	var temp = ds_map_find_value(oGame.saveData, houseUpgrades[# houseUpgradeCols.name, i]);
	if(!is_undefined(temp)) {
		houseUpgrades[# houseUpgradeCols.active, i] = temp;
	}
}