/// @desc Minute timer

minutes -= 1;

if(minutes == 17) {
	switch(minutes) {
		case 17:
			bossType = oPill;
			break;
	}
		
	var enemyCoordinates = generateEnemySpawn(irandom(3));
	var bossType;
	
	instance_create_layer(enemyCoordinates[0], enemyCoordinates[1], "Instances", bossType);
}