/// @description Makes display manager follow player
if(!instance_exists(oPlayer) || room != rGame) { exit; }
show_debug_message("yosh");
//Make display follow player
var xx = oPlayer.x;
var yy = oPlayer.y;

/*
x = lerp(x, xx + oPlayer.image_xscale * 16, 0.3);
y = lerp(y, yy + oPlayer.image_yscale * 16, 0.3);*/
x = xx;
y = yy;

if (keyboard_check_pressed(ord("Z"))) {
	zoom++;
	if (zoom > maxZoom) {
		zoom = 1;	
	}
	window_set_size(idealWidth*zoom, idealHeight*zoom);
	surface_resize(application_surface, idealWidth*zoom, idealHeight*zoom);
	alarm[0] = 1;
}