/// @desc

if(global.pause) { exit; }

if(!collision_rectangle(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0]), camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0]), self, true, false)) {
	state = "reload";	
}