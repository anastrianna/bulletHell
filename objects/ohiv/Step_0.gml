/// @description Insert description here
if(global.pause) { exit; }
event_inherited();

for(var i = 0; i < ds_list_size(targetsInRange); i++) {
	with(targetsInRange[| i]) {
		slowed = true;
		self.alarm[0] = room_speed * other.slowDuration;
	}
}