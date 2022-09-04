/// @desc

if(global.pause) { exit; }

if(currentHP <= 0) {
	instance_destroy(self);
}