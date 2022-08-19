/// @desc

getInput();

//Movement
//Alter speed if moving at an angle
var xMov = hMov * movSpeed;
var yMov = vMov * movSpeed;
if(hMov != 0 && vMov != 0) {
	xMov *= cos(45);
	yMov *= sin(45);
}

#region Movement/Collision
if(place_meeting(x+xMov, y, oBarrier)) {
	var temp = 0;
	while(!place_meeting(x+temp+hMov, y, oBarrier)) {
		temp += hMov;
	}
	xMov = temp;
}

if(place_meeting(x, y+yMov, oBarrier)) {
	var temp = 0;
	while(!place_meeting(x, y+temp+vMov, oBarrier)) {
		temp += vMov;
	}
	yMov = temp;	
}

if(xMov != 0 || yMov != 0) {
	x += xMov;
	y += yMov;
}
#endregion Movement/Collision

switch(state) {
	case "hitstun":
		image_index = 1;
		if(alarm[0] < 0) {
			alarm[0] = room_speed * 0.5;	
		}
		break;
	case "default":
		image_index = 0;
		break;
}