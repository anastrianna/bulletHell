/// @desc Clear target list and repopulate
if(global.pause) { exit; }

ds_list_clear(targetsInRange);
collision_circle_list(x, y, range*aoeRangeFactor, oEnemy, true, true, targetsInRange, false);

event_inherited();