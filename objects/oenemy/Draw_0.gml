/// @desc

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_font(fDescriptions);
draw_text(x, y - 30, string(currentHP));

if(global.pause) { exit; }

if(infectedTime && !alarm[1]%3) {
	var spawnx = x + irandom(20) - 10;
	var spawny = y + irandom(20) - 10;
		
	var particle = instance_create_layer(spawnx, spawny, "TopEffects", oRisingParticle);	
	particle.sprite_index = sInfectedParticle;
}