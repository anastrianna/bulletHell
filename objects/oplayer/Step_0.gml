/// @desc

getInput();

var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), "Health Regen");
if(global.playerUpgrades[# upgradesColumns.currentTier, row]) {
	if(alarm[3] < 0) { alarm[3] = room_speed * 30; }
}

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
	playerFaceDirection(xMov, yMov);
	
	x += xMov;
	y += yMov;
}
#endregion Movement/Collision

switch(state) {
	case "hitstun":
		image_index = 1;
		if(alarm[1] < 0) {
			alarm[1] = room_speed * hitStun;	
		}
		break;
	case "default":
		image_index = 0;
		
		if(alarm[2] < 0) {
			var atkSpeed = baseAtkSpeed * (100/(atkSpeedBuff + 100));

			alarm[2] = room_speed * atkSpeed;
		}
		break;
}