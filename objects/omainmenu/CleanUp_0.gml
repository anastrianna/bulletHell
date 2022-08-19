var i = 0, arrayLen = array_length_1d(menuPages);
repeat (arrayLen) {
	ds_grid_destroy(menuPages[i]);
	i++;
}