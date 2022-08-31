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