/// @desc Basic Attack
var spread = 0;

for(var i = 0; i <= oPlayer.bonusProjectiles; i++) {
	if(i > 0) { 
		spread = irandom(19) + 1;
		
		if(irandom(1)) { spread -= 2*spread; }
	}
	var proj = instance_create_layer(x, y, "Instances", oSpore);
	proj.damage = atkDamage;
	proj.movSpeed = projectileSpeed;
	proj.direction = point_direction(x, y, mouse_x, mouse_y) + spread;
	proj.lifeSpan = projectileLifeSpan;
	if(ds_list_find_index(oPlayer.activeMutations, "Reverse Shot") != -1) {
		var proj = instance_create_layer(x, y, "Instances", oSpore);
		proj.damage = atkDamage;
		proj.movSpeed = projectileSpeed;
		proj.direction = point_direction(mouse_x, mouse_y, x, y) + spread;
		proj.lifeSpan = projectileLifeSpan;
	}
}