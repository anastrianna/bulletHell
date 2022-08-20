///@desc Set lifespan, speed, and check for enemy collision
if(alarm[0] < 0) {
	alarm[0] = room_speed * lifeSpan;	
}

speed = movSpeed;

if(place_meeting(x, y, oEnemy)) {
	with(instance_position(x, y, oEnemy)) {
		self.currentHP -= other.damage;
		instance_destroy(other);
	}
}