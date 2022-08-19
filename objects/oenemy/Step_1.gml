/// @desc

if(place_meeting(x, y, oPlayer) && oPlayer.state == "default") {
	oPlayer.currentHP -= 1;
	oPlayer.state = "hitstun";
}