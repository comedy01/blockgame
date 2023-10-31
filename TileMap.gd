extends TileMap

const SELECTED_BLOCK = Vector2(3, 1) # dirt for now

func selected_tile() -> Vector2:
	return local_to_map(get_global_mouse_position())

func _process(delta: float) -> void:
	if (Input.is_action_pressed("left_click")):
		erase_cell(0, selected_tile())
	
	if (Input.is_action_pressed("right_click")):
		set_cell(0, selected_tile(), 0, SELECTED_BLOCK)
