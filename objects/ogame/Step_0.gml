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
		instance_create_layer(0, 0, "Instances", oInfluenza);
	} else if(!instance_exists(oUI)) { 
		instance_create_layer(0, 0, "Processes", oUI);
	} else if(!instance_exists(oEnemySpawner)) { 
		instance_create_layer(0, 0, "Processes", oEnemySpawner);
	} else if(oEnemySpawner.state == "default") { 
		oEnemySpawner.state = "active";
	}
}