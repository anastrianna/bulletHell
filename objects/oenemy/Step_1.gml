/// @desc
event_inherited();

if(place_meeting(x, y, oPlayer) && oPlayer.state == "default") {
	dealDamage(oPlayer, 1);

	oPlayer.state = "hitstun";
}

