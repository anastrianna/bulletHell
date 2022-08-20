/// @desc

oPlayer.experience += value;

if(ds_list_find_index(oPlayer.activeUpgradeList, "Infestation") != -1) {
	for(var i = 0; i < 5; i++) {
		var spore = instance_create_layer(x, y, "Instances", oSpore);	
		spore.damage = oPlayer.atkDamage;
		spore.movSpeed = oPlayer.projectileSpeed;
		spore.lifeSpan = oPlayer.projectileLifeSpan;
		spore.direction = random(360);
	}
}