extends TileMap

var blocks: Array = [
	Block.new(0, Vector2(1, 1), "Grassy dirt block"),
	Block.new(0, Vector2(3, 1), "Dirt block"),
	Block.new(0, Vector2(5, 1), "Stone block"),
	Block.new(0, Vector2(7, 1), "Log block"),
	Block.new(0, Vector2(9, 1), "Spike block"),
	Block.new(0, Vector2(11, 1), "Window"),
	Block.new(0, Vector2(13, 1), "Table")]

var selected_block_index: int = 0

enum ScrollDirection { UP, DOWN }

func log_selected_block() -> void:
	print("Currently selected block: %s" % blocks[selected_block_index].name)

func change_block_selection(direction: ScrollDirection) -> void:
	match direction:
		ScrollDirection.UP:
			selected_block_index += 1
			if selected_block_index == blocks.size():
				selected_block_index = 0
		ScrollDirection.DOWN:
			if selected_block_index == 0:
				selected_block_index = blocks.size()
			selected_block_index -= 1
	log_selected_block()

func selected_tile() -> Vector2:
	return local_to_map(get_global_mouse_position())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll_up"):
		change_block_selection(ScrollDirection.UP)

	if Input.is_action_just_pressed("scroll_down"):
		change_block_selection(ScrollDirection.DOWN)
	
	if Input.is_action_pressed("left_click"):
		erase_cell(0, selected_tile())

	if Input.is_action_pressed("right_click"):
		var tile: Vector2 = selected_tile()
		if get_cell_source_id(0, tile) == -1:
			var block: Block = blocks[selected_block_index]
			set_cell(0, tile, block.source_id, block.atlas_coords)
