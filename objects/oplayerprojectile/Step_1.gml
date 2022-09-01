///@desc Check for enemy collision
event_inherited();

if(place_meeting(x, y, oEnemy)) {
	with(instance_position(x, y, oEnemy)) {
		dealDamage(self, other.damage);
		
		var row = ds_grid_value_y(global.upgrades, 0, 0, 0, ds_grid_height(global.upgrades), "Infection");
		if(global.upgrades[# upgradesColumns.currentTier, row]) {
			self.infectedTime = oPlayer.infectionDuration;
		}
		instance_destroy(other);
	}
}