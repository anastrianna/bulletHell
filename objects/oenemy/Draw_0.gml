/// @desc

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

draw_text(x, y - 30, string(currentHP));

if(infectedTime && !alarm[1]%3) {
	var spawnx = x + irandom(20) - 10;
	var spawny = y + irandom(20) - 10;
		
	var particle = instance_create_layer(spawnx, spawny, "TopEffects", oRisingParticle);	
	particle.sprite_index = sInfectedParticle;
}