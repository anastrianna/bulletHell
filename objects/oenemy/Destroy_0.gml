/// @desc

oPlayer.experience += value;

if(infested) {
	for(var i = 0; i < 5+oPlayer.bonusProjectiles; i++) {
		var spore = instance_create_layer(x, y, "Instances", oSpore);	
		spore.damage = oPlayer.atkDamage;
		spore.movSpeed = oPlayer.projectileSpeed;
		spore.lifeSpan = oPlayer.projectileLifeSpan;
		spore.direction = random(360);
	}
}