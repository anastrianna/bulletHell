/// @desc

if(global.pause) { exit; }

var childCount = ds_list_size(children);
if(childCount < bonusProjectiles + baseProjectiles) {
	repeat(bonusProjectiles + baseProjectiles - childCount) {
		var child = instance_create_layer(x, y, "Instances", oCancerChild);
		ds_list_add(children, child);
	}
} else if(childCount > bonusProjectiles + baseProjectiles) {
	repeat(childCount - (bonusProjectiles + baseProjectiles)) {
		ds_list_delete(children, childCount-1);
	}
}

var temp = false;
with(oCancerChild) {
	if(state == "load") { temp = true; }
}
loading = temp;

event_inherited();