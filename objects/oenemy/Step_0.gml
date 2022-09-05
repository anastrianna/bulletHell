/// @desc Movement
if(global.pause || !instance_exists(oPlayer)) { exit; }

if(infectedTime && alarm[1] < 0) { alarm[1] = room_speed * tickRate; }