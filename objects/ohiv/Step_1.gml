/// @desc Clear target list and repopulate

ds_list_clear(targetsInRange);
collision_circle_list(x, y, range*aoeRangeFactor, oEnemy, true, true, targetsInRange, false);

event_inherited();