///@func applyUpgrade(name)
///@desc Apply player upgrade
///@arg name Name of upgrade
function applyUpgrade(name) {
	switch(name) {
		case "Strength":
			oPlayer.atkDamage += oPlayer.baseAtkDamage;
			break;
		case "Speed":
			oPlayer.atkSpeedBuff += 15;
			break;
	}
	
	ds_list_add(oPlayer.activeUpgradeList, name);
	
	ds_list_delete(global.availableUpgrades, ds_list_find_index(global.availableUpgrades, name));
}