//Draw Background
var viewWidth = camera_get_view_width(view_camera[0]);
var viewHeight = camera_get_view_height(view_camera[0]);

if(upgradesMenuBool) {
	var c = c_white;
	var cc = c_grey;
	var startx = viewWidth * 0.1;
	var starty = viewHeight * 0.1;
	var menuWidth = viewWidth - 2*startx;
	var menuHeight = viewHeight - 2*starty;
	
	rectangleWithOutline(startx, starty, startx + menuWidth, starty + menuHeight, c, cc);
	
	var xx = viewWidth/2;
	var yy = starty + 20;
	
	draw_text(xx, yy, "Bills: " + string(oGame.bills));
} else {
	var c = c_black;
	draw_rectangle_color(0, 0, viewWidth, viewHeight, c, c, c, c, false);

	var dsGrid = menuPages[page], dsHeight = ds_grid_height(dsGrid);
	var yBuffer = 32, xBuffer = 16, padding = 4;
	var starty = (viewHeight/2) - ((dsHeight-1)/2*yBuffer), startx = viewWidth/2;

	//Draw button elements
	draw_set_font(fMenus);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);

	var ltx = startx - xBuffer, lty, xo;
	var yy = 0;
	if (page >= settingsStart && page <= settingsEnd) {
		draw_set_halign(fa_right);
		repeat (dsHeight) {
			lty = starty + (yy*yBuffer);
			c = c_white;
			xo = 0;
	
			if (yy == menuOption[page]) {
				c = c_red;
				xo = -(xBuffer/2);
			}
	
			draw_text_color(ltx+xo, lty, dsGrid[# 0, yy], c, c, c, c, 1);
			yy++;
		}
		draw_line(startx, starty - yBuffer, startx, lty+yBuffer);
	}
	else {
		repeat (dsHeight) {
			lty = starty + (yy*yBuffer);
			c = c_white;
	
			if (yy == menuOption[page]) {
				c = c_red;
			}
	
			draw_rectangle_color(ltx-viewWidth*.2, lty-yBuffer/2+padding, ltx+viewWidth*.2, lty+yBuffer/2-padding, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
			draw_text_color(ltx, lty, dsGrid[# 0, yy], c, c, c, c, 1);
			yy++;
		}
	}

	//Draw setting elements
	draw_set_halign(fa_left);

	var rtx = startx + xBuffer, rty;

	yy = 0;
	repeat (dsHeight) {
		rty = starty + (yy*yBuffer);
		switch	(dsGrid[# 1, yy]) {
			case menuElementType.shift:
				var currentVal = dsGrid[# 3, yy];
				var currentArray = dsGrid[# 4, yy];
				var leftShift = "<< ", rightShift = " >>";
			
				if (currentVal == 0) leftShift = "";
				if (currentVal == array_length_1d(currentArray)-1) rightShift = "";
				c = c_white;
			
				if (yy == menuOption[page]) { c = c_yellow; }
				draw_text_color(rtx, rty, leftShift + currentArray[currentVal] + rightShift, c, c, c, c, 1);
				break;
			case menuElementType.slider:
				var len = 64;
				var currentVal = dsGrid[# 3, yy];
				var currentArray = dsGrid[# 4, yy];
				var circlePos = ((currentVal - currentArray[0]) / (currentArray[1] - currentArray[0]));
				c = c_white;
			
				draw_line_width(rtx, rty, rtx + len, rty, 2);
				if (yy == menuOption[page]) { c = c_yellow; }
				draw_circle_color(rtx + (circlePos*len), rty, 4, c, c, false);
				draw_text_color(rtx + (len*1.2), rty, string(floor(circlePos*100)) + "%", c, c, c, c, 1);
				break;
			case menuElementType.toggle:
				var currentVal = dsGrid[# 3, yy];
				var c1, c2;
				c = c_white;
				if (yy == menuOption[page]) { c = c_yellow; }
			
				if (currentVal == 0) { c1 = c; c2 = c_dkgray; }
				else { c1 = c_dkgray; c2 = c; }
			
				draw_text_color(rtx, rty, "ON", c1, c1, c1, c1, 1);
				draw_text_color(rtx + 32, rty, "OFF", c2, c2, c2, c2, 1);
				break;
			case menuElementType.input:
				var currentVal = dsGrid[# 3, yy];
				var stringVal;
			
				switch (currentVal) {
					case vk_up: stringVal = "UP KEY"; break;
					case vk_down: stringVal = "DOWN KEY"; break;
					case vk_left: stringVal = "LEFT KEY"; break;
					case vk_right: stringVal = "RIGHT KEY"; break;
					default: stringVal = chr(currentVal); break;
				}
			
				c = c_white;
				if (inputting && yy = menuOption[page]) { c = c_yellow; }
				draw_text_color(rtx, rty, stringVal, c, c, c, c, 1);
				break;
			case menuElementType.textInput:
				var len = viewWidth*0.35;
				var height = 32;
				var cc = c_black;
				var textValue = "";
				c = c_gray;
			
				if(yy == menuOption[page]) {
					if(inputting) {
						c = c_white;
						textValue = helpfulString;
					} else {
						textValue = dsGrid[# 2, menuOption[page]];
					}
				} else { textValue = dsGrid[# 2, yy]; }
			
				draw_rectangle_color(rtx, rty-(height/2), rtx+len, rty+(height/2), c, c, c, c, true);
				draw_rectangle_color(rtx, rty-(height/2), rtx+len, rty+(height/2), cc, cc, cc, cc, false);
				draw_text(rtx, rty, textValue);
			
				break;
		}
		yy++;
	}
}