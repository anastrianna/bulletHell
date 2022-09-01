/// @desc Spawn enemies

//0 - top, 1 - right, 2 - down, 3 - left 
var quadrant = 0;

var difficulty = max(floor((maxTime - minutes)/2), 1);

var enemyCount = 4;
if(instance_exists(oBoss)) { enemyCount = 2; }

repeat(enemyCount) {
	var enemyCoordinates = generateEnemySpawn(quadrant);

	if(quadrant == 3) {
		quadrant = 0;	
	} else { quadrant++; }

	var enemy = instance_create_layer(enemyCoordinates[0], enemyCoordinates[1], "Instances", oNeutrophil);
	enemy.maxHP = enemy.maxHP * difficulty;
	enemy.currentHP = enemy.maxHP;
	enemy.value = enemy.value * ceil((maxTime - minutes)/2);
}

if(minutes < 19 && instance_number(oLymphocyte) < 10) {
	var enemyCoordinates = generateEnemySpawn(irandom(3));
	
	var enemy = instance_create_layer(enemyCoordinates[0], enemyCoordinates[1], "Instances", oLymphocyte);
	enemy.maxHP = enemy.maxHP * difficulty;
	enemy.currentHP = enemy.maxHP;
	enemy.value = enemy.value * ceil((maxTime - minutes)/2);
}