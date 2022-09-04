/// @desc
if(global.pause) { exit; }

switch(state) {
	case "active":
		if(alarm[0] < 0) {
			alarm[0] = room_speed * 1;
		}
		if(alarm[1] < 0) {
			alarm[1] = room_speed * 60;
		}
		break;
	case "default":
		break;
}