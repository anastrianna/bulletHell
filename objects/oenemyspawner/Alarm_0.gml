/// @desc Spawn enemies

//0 - top, 1 - right, 2 - down, 3 - left 
var quadrant = 0;
	
repeat(4) {
	#region Enemy spawn point
	//Calculate enemy spawn position
	var vWidth = camera_get_view_width(view_camera[0]);
	var vHeight = camera_get_view_height(view_camera[0]);
	var camx = camera_get_view_x(view_camera[0]);
	var camy = camera_get_view_y(view_camera[0]);
	var offset = 10;

	var xx, yy;

	switch(quadrant) {
		case 0:
			xx = random(vWidth) + camx;
			yy = camy - offset;
			break;
		case 1:
			xx = camx + vWidth + offset;
			yy = random(vHeight) + camy;
			break;
		case 2:
			xx = random(vWidth) + camx;
			yy = camy + vHeight + offset;
			break;
		case 3:
			xx = camx - offset;
			yy = random(vHeight) + camy;
			break;
	}

	if(quadrant == 3) {
		quadrant = 0;	
	} else { quadrant++; }
	#endregion Enemy spawn point

	var difficulty = maxTime - minutes;

	var enemy = instance_create_layer(xx, yy, "Instances", oNeutrophil);
	enemy.maxHP = enemy.maxHP * difficulty;
	enemy.currentHP = enemy.maxHP;
}