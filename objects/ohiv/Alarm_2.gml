/// @desc Basic Attack

for(var i = 0; i < ds_list_size(targetsInRange); i++) {
	targetsInRange[| i].currentHP -= atkDamage;
}