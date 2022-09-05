///@func playerUpgrade()
///@desc Upgrade character upon level up or boss kill
///@arg state State for UI
function playerUpgrade(state) {
	with(oUI) {
		ds_list_clear(upgradeList);
		var tempList = ds_list_create();
		switch(state) {
			case "upgrade":
				ds_list_copy(tempList, global.availableUpgrades);

				var choiceCount = min(global.maxChoices, ds_list_size(tempList));
				for(var i = 0; i < choiceCount; i++) {
					var temp = irandom(ds_list_size(tempList)-1);
					ds_list_add(upgradeList, tempList[| temp]);
					ds_list_delete(tempList, temp);
				}
				break;
			case "mutation":
				var temp = irandom(ds_list_size(oPlayer.availableMutations)-1);
				
				ds_list_add(upgradeList, oPlayer.availableMutations[| temp]);
				ds_list_delete(oPlayer.availableMutations, temp);
				break;
		}
		
		ds_list_destroy(tempList);
		
		pauseToggle(state);
	}
}

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
		case "Range":
			oPlayer.range += oPlayer.baseRange/2;
			break;
		case "Pickup Radius":
			oPlayer.pickupRadius += oPlayer.basePickupRadius;
			break;
	}
	
	var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), name);
	global.playerUpgrades[# upgradesColumns.currentTier, row] += 1;
	
	if(!(ds_list_find_index(global.activeUpgrades, name)+1)) { ds_list_add(global.activeUpgrades, name); }
	
	//Remove upgrade from available upgrades list if max tiers and check for unlocked upgrades
	if(global.playerUpgrades[# upgradesColumns.currentTier, row] == global.playerUpgrades[# upgradesColumns.maxTier, row]) {
		ds_list_delete(global.availableUpgrades, ds_list_find_index(global.availableUpgrades, name));
		
		var unlock = global.playerUpgrades[# upgradesColumns.unlock, row];
		if(is_string(unlock)) { ds_list_add(global.availableUpgrades, unlock); }
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
	txt += "";
	if(!tier) {
		return txt;
	} else {
		txt += " ";	
	}
	
	if(tier < 3) { 
		for(var i = 0; i < tier; i++) { txt += "I"; } 
	} else if(tier == 3) {
		txt += "IV";
	} else if(tier == 4) {
		txt += "V";
	}
	
	return txt;
}