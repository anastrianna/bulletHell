/// @desc Clear target list and repopulate
ds_list_clear(targetsInRange);
collision_circle_list(x, y, radius, oEnemy, true, true, targetsInRange, false);