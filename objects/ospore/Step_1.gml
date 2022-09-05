/// @desc

if(global.pause || is_undefined(startx) || is_undefined(starty) || is_undefined(dir)) { exit; }

if(point_distance(x, y, startx, starty) > range) {
	instance_destroy(self);
}

x += lengthdir_x(movSpeed, dir);
y += lengthdir_y(movSpeed, dir);

if(place_meeting(x, y, oEnemy)) {
	with(instance_position(x, y, oEnemy)) {
		if(self.currentHP > 0) {
			dealDamage(self, other.damage);
		
			var row = ds_grid_value_y(global.playerUpgrades, 0, 0, 0, ds_grid_height(global.playerUpgrades), "Infection");
			if(global.playerUpgrades[# upgradesColumns.currentTier, row]) {
				self.infectedTime = oPlayer.infectionDuration;
			}
			
			if(other.infestor) {
				self.infested = true;
			}
			instance_destroy(other);
		}
	}
}