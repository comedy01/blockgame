extends TileMap

func _process(delta):
	if (Input.is_action_just_pressed("left_mb")):
		var tile : Vector2 = local_to_map(get_global_mouse_position())
		set_cell(0 , tile, 0, Vector2i.ZERO)
	
	if (Input.is_action_just_pressed("right_mb")):
		var tile : Vector2 = local_to_map(get_global_mouse_position())
		erase_cell(0, tile)
	
