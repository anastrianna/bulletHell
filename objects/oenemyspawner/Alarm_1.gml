/// @desc Minute timer

minutes -= 1;

if(minutes == 17) {
	switch(minutes) {
		case 17:
			bossType = oPill;
			break;
	}
		
	//Calculate enemy spawn position
	var vWidth = camera_get_view_width(view_camera[0]);
	var vHeight = camera_get_view_height(view_camera[0]);
	var camx = camera_get_view_x(view_camera[0]);
	var camy = camera_get_view_y(view_camera[0]);
	var offset = 10;
	var bossType;

	var xx, yy;

	switch(irandom(3)) {
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
	
	instance_create_layer(xx, yy, "Instances", bossType);
}