///@func applyUpgrade(name)
///@desc Apply player upgrade
///@arg name Name of upgrade
function applyUpgrade(name) {
	switch(name) {
		case "Strength":
			oPlayer.atkDamage += oPlayer.baseAtkDamage;
			break;
		case "Attack Speed":
			oPlayer.atkSpeedBuff += 15;
			break;
		case "Projectile Speed":
			oPlayer.projectileSpeed += 3;
			break;
		case "Health":
			oPlayer.maxHP += 5;
			oPlayer.currentHP += 5;
			break;
		case "Crit":
			oPlayer.critChance += 20;
			break;
		case "Projectile Count":
			oPlayer.bonusProjectiles += 1;
			break;
		case "Movement Speed":
			oPlayer.movSpeed += 1;
			break;
		case "Effect Power":
			oPlayer.effectPower += 25;
			break;
	}
	
	var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), name);
	global.upgrades[# upgradesColumns.currentTier, row] += 1;
	
	if(global.upgrades[# upgradesColumns.currentTier, row] == global.upgrades[# upgradesColumns.maxTier, row]) {
		ds_list_delete(global.availableUpgrades, ds_list_find_index(global.availableUpgrades, name));
	}
}

///@func applyMutation(name)
///@desc Apply player mutation
///@arg name Name of mutation
function applyMutation(name) {
	switch(name) {
		case "Immuno Compromise":
			oHIV.slowPower = 50;
			break;
	}
	
	ds_list_add(oPlayer.activeMutations, name);
}

///@func fixUpgradeName()
///@desc Add tier to upgrade name
///@arg txt Text to add
///@arg tier Current tier
function fixUpgradeName(txt, tier) {
	txt += " ";
	if(tier < 3) { 
		for(var i = 0; i <= tier; i++) { txt += "I"; } 
	} else if(tier == 3) {
		txt += "IV";
	} else if(tier == 4) {
		txt += "V";
	}
	
	return txt;
}