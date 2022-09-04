///@desc Check for enemy collision
if(global.pause) { exit; }
event_inherited();

if(place_meeting(x, y, oEnemy)) {
	with(instance_position(x, y, oEnemy)) {
		if(currentHP > 0) {
			dealDamage(self, other.damage);
		
			var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), "Infection");
			if(global.playerUpgrades[# upgradesColumns.currentTier, row]) {
				self.infectedTime = oPlayer.infectionDuration;
			}
			instance_destroy(other);
		}
	}
}