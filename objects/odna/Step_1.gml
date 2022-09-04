/// @desc

if(global.pause) { exit; }

if(place_meeting(x, y, oPlayer)) {
	oPlayer.experience += 1;
	instance_destroy(self);
}