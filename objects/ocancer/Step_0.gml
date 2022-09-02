/// @desc

getInput();

var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), "Health Regen");
if(global.playerUpgrades[# upgradesColumns.currentTier, row]) {
	if(alarm[3] < 0) { alarm[3] = room_speed * 30; }
}

#region Movement/Collision
//Alter speed if moving at an angle
var xMov = hMov * movSpeed;
var yMov = vMov * movSpeed;
if(hMov != 0 && vMov != 0) {
	xMov *= cos(45);
	yMov *= sin(45);
}

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
		break;
}

#region Child orbit
var tempList = ds_list_create();
for(var i = 0; i < ds_list_size(children); i++) {
	with(children[| i]) {
		if(state == "default") { ds_list_add(tempList, self); }
	}
}

var orbitRadius = sprite_get_width(sprite_index)/2;
var orbitCount = ds_list_size(tempList);
for(var i = 0; i < orbitCount; i++) {
	tempList[| i].targetx = x + lengthdir_x(orbitRadius, childDirection + (i * (360/orbitCount)));
	tempList[| i].targety = y + lengthdir_y(orbitRadius, childDirection + (i * (360/orbitCount)));
}

ds_list_destroy(tempList);
#endregion Child orbit

//Load child for firing
if(!loading && collision_circle(x, y, range, oEnemy, true, true)) {
	for(var i = 0; i < ds_list_size(children); i++) {
		if(children[| i].state == "default") {
			var target = instance_nearest(x, y, oEnemy);

			with(children[| i]) {
				self.target = target;
				state = "load";
			}

			loading = true;
			break;
		}
	}
}

childDirection++;