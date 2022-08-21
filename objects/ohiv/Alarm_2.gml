/// @desc Basic Attack

for(var i = 0; i < ds_list_size(targetsInRange); i++) {
	dealDamage(targetsInRange[| i], atkDamage);
	
	var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), "Infestation");
	if(global.upgrades[# upgradesColumns.currentTier, row]) {
		targetsInRange[| i].infested = true;
	}
		
	row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), "Infection");
	if(global.upgrades[# upgradesColumns.currentTier, row]) {
		targetsInRange[| i].infected = oPlayer.infectionDuration;
	}
}