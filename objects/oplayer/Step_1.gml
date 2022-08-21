/// @desc Check experience for level up, check health regen alarm

event_inherited();

if(experience >= levelCost && ds_list_size(global.availableUpgrades)) { 
	experience = 0;
	levelCost *= 2;
	playerUpgrade("upgrade");
}