///@desc Check for player collision
event_inherited();

if(place_meeting(x, y, oPlayer)) {
	with(oPlayer) {
		dealDamage(self, other.damage);

		instance_destroy(other);
	}
}