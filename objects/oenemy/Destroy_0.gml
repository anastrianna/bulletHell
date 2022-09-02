/// @desc
oUI.kills += 1;

repeat(value) {
	var spawnx = x + irandom(20) - 10;
	var spawny = y + irandom(20) - 10;
	
	instance_create_layer(spawnx, spawny, "Instances", oDNA);
}

if(infested) {
	for(var i = 0; i < 5+oPlayer.bonusProjectiles; i++) {
		var spore = instance_create_layer(x, y, "Instances", oSpore);	
		spore.startx = x;
		spore.starty = y;
		spore.damage = oPlayer.atkDamage;
		spore.movSpeed = oPlayer.projectileSpeed;
		spore.range = oPlayer.range;
		spore.direction = random(360);
	}
}

with(oCancerChild) {
	if(target.id == other.id) {
		target = -1;
	}
}