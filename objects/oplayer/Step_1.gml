/// @desc Check experience for level up, check health regen alarm
if(global.pause) { exit; }
event_inherited();

if(experience >= levelCost && ds_list_size(global.availableUpgrades)) { 
	experience -= levelCost;
	var levelScale = 2;
	if(levelCost > 200) {
		levelScale = 1.5;
	}
	levelCost = floor(levelCost * levelScale);
	playerUpgrade("upgrade");
}