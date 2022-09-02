/// @desc Fire Projectile
if(state == "attack" && instance_exists(oPlayer)) {
	var antibody = instance_create_layer(x, y, "Instances", oAntibody);
	antibody.startx = x;
	antibody.starty = y;
	antibody.direction = point_direction(x, y, oPlayer.x, oPlayer.y);
	antibody.movSpeed = projectileSpeed;
	antibody.range = 300;
}

if(point_distance(x, y, oPlayer.x, oPlayer.y) > range) {
	state = "move";
}