/// @desc Spawn enemies

var difficulty = maxTime - minutes;

var neutroCount = waveControl[# waveControlCols.neutroCount, wave];
if(neutroCount && instance_number(oNeutrophil) >= waveControl[# waveControlCols.neutroMax, wave]) { neutroCount = max(1, neutroCount - 2); }

repeat(neutroCount) {	
	var enemyCoordinates = generateEnemySpawn(quadrant);

	if(quadrant == 3) {
		quadrant = 0;	
	} else { quadrant++; }

	var enemy = instance_create_layer(enemyCoordinates[0], enemyCoordinates[1], "Instances", oNeutrophil);
	enemy.maxHP = enemy.maxHP * difficulty;
	enemy.currentHP = enemy.maxHP;
	enemy.value = enemy.value * ceil((maxTime - minutes)/2);
}

if(!lymphoDelay && instance_number(oLymphocyte) < waveControl[# waveControlCols.lymphoMax, wave]) {	
	var enemyCoordinates = generateEnemySpawn(irandom(3));
	
	var enemy = instance_create_layer(enemyCoordinates[0], enemyCoordinates[1], "Instances", oLymphocyte);
	enemy.maxHP = enemy.maxHP * difficulty;
	enemy.currentHP = enemy.maxHP;
	enemy.value = enemy.value * ceil((maxTime - minutes)/2);
	
	lymphoDelay = waveControl[# waveControlCols.lymphoDelay, wave];
} else {
	lymphoDelay--;	
}