/// @desc Minute timer

if(minutes == 0) { gameEnd(true); }

minutes -= 1;

if(waveControl[# waveControlCols.endTime, wave] > minutes) { wave += 1; }

if(waveControl[# waveControlCols.isBoss, wave]) {
	switch(minutes) {
		case 17:
			bossType = oPill;
			break;
	}
		
	var enemyCoordinates = generateEnemySpawn(irandom(3));
	var bossType;
	
	instance_create_layer(enemyCoordinates[0], enemyCoordinates[1], "Instances", bossType);
}