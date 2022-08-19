/// @description Sets up/manages display
idealWidth = 0;
idealHeight = 512;
zoom = 1;
maxZoom = 1;

aspectRatio = display_get_width()/display_get_height();

idealWidth = round(idealHeight*aspectRatio);

//Check for odd numbers
if (idealWidth & 1) {
	idealWidth++;
}

//Calculate max zoom
maxZoom = floor(display_get_width()/idealWidth);

window_set_size(idealWidth, idealHeight);
display_set_gui_size(idealWidth, idealHeight);
surface_resize(application_surface, idealWidth, idealHeight);

alarm[0] = 1;

camera = camera_create();