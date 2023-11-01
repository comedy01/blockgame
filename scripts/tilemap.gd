extends TileMap

var hotbar: Array = [
	Tool.new(),
	Block.new(0, Vector2(1, 1), "Grassy dirt block"),
	Block.new(0, Vector2(3, 1), "Dirt block"),
	Block.new(0, Vector2(5, 1), "Stone block"),
	Block.new(0, Vector2(7, 1), "Log block"),
	Block.new(0, Vector2(9, 1), "Spike block"),
	Block.new(0, Vector2(11, 1), "Window"),
	Block.new(0, Vector2(13, 1), "Table")]

var hotbar_selection_index: int = 0

func selected_item() -> Item:
	return hotbar[hotbar_selection_index]

func log_selected_item() -> void:
	print("Currently selected: %s" % selected_item().name)

func change_hotbar_selection(direction: int) -> void:
	hotbar_selection_index = wrapi(hotbar_selection_index + direction, 0, hotbar.size())
	log_selected_item()

func selected_tile() -> Vector2:
	return local_to_map(get_global_mouse_position())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll_up"):
		change_hotbar_selection(1)

	if Input.is_action_just_pressed("scroll_down"):
		change_hotbar_selection(-1)
	
	if Input.is_action_pressed("left_click"):
		var callback = Item.UseCallback.new()
		callback.break_block = func():
			erase_cell(0, selected_tile())
		callback.place_block = func(block: Block):
			var tile: Vector2 = selected_tile()
			if get_cell_source_id(0, tile) == -1:
				set_cell(0, tile, block.source_id, block.atlas_coords)
		selected_item().use(callback)
