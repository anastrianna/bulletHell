///@desc Set lifespan, speed, and check for enemy collision
if(alarm[0] < 0) {
	alarm[0] = room_speed * lifeSpan;	
}

speed = movSpeed;

if(place_meeting(x, y, oEnemy)) {
	with(instance_position(x, y, oEnemy)) {
		if(currentHP) {
			dealDamage(self, other.damage);
		
			if(ds_list_find_index(oPlayer.activeMutations, "Infestation")+1) {
				self.infested = true;
			}
		
			var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), "Infection");
			if(global.upgrades[# upgradesColumns.currentTier, row]) {
				self.infectedTime = oPlayer.infectionDuration;
			}
			instance_destroy(other);
		}
	}
}