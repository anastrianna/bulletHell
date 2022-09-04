/// @desc Check experience for level up, check health regen alarm
if(global.pause) { exit; }
event_inherited();

if(experience >= levelCost && ds_list_size(global.availableUpgrades)) { 
	experience -= levelCost;
	levelCost = floor(levelCost * 1.5);
	playerUpgrade("upgrade");
}