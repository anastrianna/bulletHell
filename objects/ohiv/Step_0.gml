/// @description Insert description here

event_inherited();

for(var i = 0; i < ds_list_size(targetsInRange); i++) {
	with(targetsInRange[| i]) {
		slowed = true;
		self.alarm[0] = room_speed * other.slowDuration;
	}
}