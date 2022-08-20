///@func getInput()
///@desc Get user input
function getInput() {
	//Set control variables
	var right = keyboard_check(ord("D")) || keyboard_check(vk_right);
	var left = keyboard_check(ord("A")) || keyboard_check(vk_left);
	var up = keyboard_check(ord("W")) || keyboard_check(vk_up);
	var down = keyboard_check(ord("S")) || keyboard_check(vk_down);

	var rightPress = keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right);
	var leftPress = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left);
	var upPress = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
	var downPress = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);

	var space = keyboard_check_pressed(vk_space);
	var escape = keyboard_check_pressed(vk_escape);
	var enter = keyboard_check_pressed(vk_enter);
	var rightClick = mouse_check_button_pressed(mb_right);
	var leftClick = mouse_check_button_pressed(mb_left);
	var backSpace = keyboard_check_pressed(vk_backspace);
	var tab = keyboard_check_pressed(vk_tab);

	interactButton = rightClick;
	inspectButton = leftClick;

	menuHMov = rightPress - leftPress;
	menuVMov = downPress - upPress;
	select = enter;

	hMov = right - left;
	vMov = down - up;

	back = backSpace;

	cancel = escape;

	designateZone = tab;
}

///@arg ["Name1", type1, entries1...]
///@arg ["Name2", type2, entries2...]
function createGrid() {
	var arg, i = 0;
	repeat (argument_count) {
		arg[i] = argument[i];
		i++;
	}

	i = 0;
	var gridSize = 0;
	repeat (argument_count) {
		var array = arg[i];
		gridSize = max(gridSize, array_length_1d(array));
		i++;
	}
	var dsGridId = ds_grid_create(gridSize, argument_count);

	i = 0;
	repeat (argument_count) {
		array = arg[i];
		var arrayLen = array_length_1d(array);
	
		var xx = 0;
		repeat (arrayLen) {
			dsGridId[# xx, i] = array[xx];
			xx++;
		}
		i++;
	}

	return dsGridId;
}

///@func createPopup( text )
///@desc Create popup with given text
///@arg text Text to be dispayed in popup
function createPopup(text) {
	var vWidth = camera_get_view_width(view_camera[0]);
	var vHeight = camera_get_view_height(view_camera[0]);
	var camx = camera_get_view_x(view_camera[0]);
	var camy = camera_get_view_y(view_camera[0]);
	
	var boxWidth = 0.4 * vWidth;
	var boxHeight = 0.3 * vHeight;
	
	rectangleWithOutline(camx + (vWidth - boxWidth)/2, camy + (vHeight - boxHeight)/2, camx + boxWidth + (vWidth - boxWidth)/2, camy + boxHeight + (vHeight - boxHeight)/2, c_black, c_grey);
	draw_text(camx + vWidth/2, camy + vHeight/2, text);
}

///@arg xBox x value of top left relative to view
///@arg yBox y value of top left relative to view
///@arg size Dimensions of square
///@arg text Button Text
///@arg script Button pushed script
///@arg color Color of box
///@arg arguments Script Arguments
function createSquareButton(xBox, yBox, size, text, script, color, arguments) {
	var truex = uiX(xBox);
	var truey = uiY(yBox);

	var button = instance_create_layer(truex, truey, "UI", oSquareButton);
	button.xx = xBox;
	button.yy = yBox;
	button.boxDimension = size;
	button.image_xscale = button.boxDimension;
	button.image_yscale = button.boxDimension;
	button.text = text;
	button.script = script;
	button.c = color;
	button.control = self;
	button.arguments = arguments;

	return button;
}

///@func rectangleWithOutline(startx, starty, endx, endy, outlineColor, fillColor)
///@desc Creates a rectangle with an outline
///@arg startx Upper left x position
///@arg starty Upper left y position
///@arg endx Bottom right x position
///@arg endy Bottom right y position
///@arg outlineColor Color of box outline
///@arg fillColor Background color of box
function rectangleWithOutline(startx, starty, endx, endy, outlineColor, fillColor) {
	draw_rectangle_color(startx, starty, endx, endy, outlineColor, outlineColor, outlineColor, outlineColor, true);
	draw_rectangle_color(startx, starty, endx, endy, fillColor, fillColor, fillColor, fillColor, false);
}

///@func uiX()
///@desc Returns new x value
///@arg uix X relative to top left
function uiX(uix) {
	return camera_get_view_x(view_camera[0]) + uix;
}

///@func uiY()
///@desc Returns new y value 
///@arg uiy Y relative to top left
function uiY(uiy) {
	return camera_get_view_y(view_camera[0]) + uiy;
}

///@arg offx x offset
///@arg offy y offset
///@arg strList List of strings
function stringRise(offx, offy, str) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fRisingPopup);
	draw_set_color(c_black);
	draw_text(x+offx, y-offy-riseOffset, str);
	riseOffset++;
}

///@func randomControllerName()
///@desc Create random name for lobby
function randomControllerName() {
	var name = "";

	var firstName = ["Bill", "Stan", "Chuck", "Karl", "Steve", "Nick", "Matt"];

	var lastName = ["William", "Rork", "Baker", "Alf", "Cuck", "Bernard"];

	var ending = ["", "son", "ton", "s", "ford", "ington", " Jr.", " Sr.", " the Third", " at Law"];

	if(irandom(1000) == 69) { name += "The Honorable "; }

	var r = irandom(array_length_1d(firstName)-1);
	name +=	firstName[r];

	name += " ";

	var r = irandom(array_length_1d(lastName)-1);
	name +=	lastName[r];

	var r = irandom(array_length_1d(ending)-1);
	name +=	ending[r];

	return name;
}

///func doNothing()
///desc Do nothing
function doNothing() {

}
