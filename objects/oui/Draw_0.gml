var vWidth = camera_get_view_width(view_camera[0]);
var vHeight = camera_get_view_height(view_camera[0]);
var camx = camera_get_view_x(view_camera[0]);
var camy = camera_get_view_y(view_camera[0]);

if(pause) {
	draw_sprite_ext(pauseSurface, 0, camx, camy, 1, 1, 0, c_white, 1);
}