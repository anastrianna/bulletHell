/// @desc Basic Attack

for(var i = 0; i < ds_list_size(targetsInRange); i++) {
	dealDamage(targetsInRange[| i], atkDamage);

	var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), "Infection");
	if(global.playerUpgrades[# upgradesColumns.currentTier, row]) {
		targetsInRange[| i].infectedTime = oPlayer.infectionDuration;
	}
}