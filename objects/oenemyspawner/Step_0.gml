/// @desc

switch(state) {
	case "active":
		if(alarm[0] < 0) {
			alarm[0] = room_speed * 1;
		}
		break;
	case "default":
		break;
}