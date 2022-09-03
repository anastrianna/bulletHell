/// @desc

if(room == rInit) {
	if(!instance_exists(oDisplayManager)) { 
		instance_create_layer(0, 0, "Processes", oDisplayManager); 
	} else { room_goto(rMenu); }
} else if(room == rMenu) {
	if(!instance_exists(oMainMenu)) { 
		instance_create_layer(0, 0, "Processes", oMainMenu); 
	}
} else if(room == rGame) {
	if(!instance_exists(oPlayer)) { 
		var player = instance_create_layer(0, 0, "Instances", playerUnit);
		
		#region House Upgrades
		var temp = ds_map_find_value(saveData, "HEATING");
		if(!is_undefined(temp)) { 
			if(temp) {
				player.maxHP += 2;
				player.currentHP = player.maxHP;
			}
		}
		
		temp = ds_map_find_value(saveData, "TAINTED WATER");
		if(!is_undefined(temp)) { 
			if(temp) {
				player.range += 50;
			}
		}
		
		temp = ds_map_find_value(saveData, "BUSTED PLUMBING");
		if(!is_undefined(temp)) { 
			if(temp) {
				player.baseAtkDamage = floor(player.baseAtkDamage * 1.5);
				player.atkDamage = player.baseAtkDamage;
			}
		}
		
		temp = ds_map_find_value(saveData, "TRASH BUILDUP");
		if(!is_undefined(temp)) { 
			if(temp) {
				player.bonusProjectiles += 1;
			}
		}
		#endregion House Upgrades
	} else if(!instance_exists(oUI)) {
		instance_create_layer(0, 0, "Processes", oUI);
	} else if(!instance_exists(oEnemySpawner)) { 
		instance_create_layer(0, 0, "Processes", oEnemySpawner);
	} else if(oEnemySpawner.state == "default") { 
		oEnemySpawner.state = "active";
	}
}