/// @desc Basic Attack
var spread = 0;

for(var i = 0; i <= oPlayer.bonusProjectiles; i++) {
	//Spread for extra projectiles
	if(i > 0) { 
		spread = irandom(19) + 1;
		
		if(irandom(1)) { spread -= 2*spread; }
	}
	
	var infestor = ds_list_find_index(oPlayer.activeMutations, "Infestation")+1;
	
	var proj = instance_create_layer(x, y, "Instances", oSpore);
	proj.startx = x;
	proj.starty = y;
	proj.damage = atkDamage;
	proj.movSpeed = projectileSpeed;
	proj.range = range;
	proj.dir = point_direction(x, y, mouse_x, mouse_y) + spread;
	if(infestor) { proj.infestor = true; }

	if(ds_list_find_index(oPlayer.activeMutations, "Reverse Shot")+1) {
		proj = instance_create_layer(x, y, "Instances", oSpore);
		proj.startx = x;
		proj.starty = y;
		proj.damage = atkDamage;
		proj.movSpeed = projectileSpeed;
		proj.range = range;
		proj.dir = point_direction(mouse_x, mouse_y, x, y) + spread;
		if(infestor) { proj.infestor = true; }
	}
}