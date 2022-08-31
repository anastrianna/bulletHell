/// @desc
event_inherited();

repeat(ds_list_size(children)) {
	instance_destroy(children[| ds_list_size(children)-1]);	
}
ds_list_destroy(children);