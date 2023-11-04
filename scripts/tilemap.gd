extends TileMap

# Map atlas coordinates to required tool types
var required_tool_types: Array[Dictionary] = [{}, {}]

func block(tool_type: Tool.Type, layer: int, atlas_coords: Vector2, name: String) -> Block:
	required_tool_types[layer][atlas_coords] = tool_type
	return Block.new(layer, atlas_coords, name)

func tool_type_for(layer: int, tile: Vector2) -> Tool.Type:
	return required_tool_types[layer][get_cell_atlas_coords(layer, tile) as Vector2]

var hotbar: Array[Item] = [
	Tool.new(Tool.Type.PICKAXE, 30,  "Wooden pickaxe"),
	Tool.new(Tool.Type.PICKAXE, 100, "Iron pickaxe"),
	Tool.new(Tool.Type.HAMMER,  30,  "Wooden hammer"),
	Tool.new(Tool.Type.HAMMER,  100, "Iron hammer"),
	Tool.new(Tool.Type.AXE,     30,  "Wooden axe"),
	Tool.new(Tool.Type.AXE,     100, "Iron axe"),
	block(Tool.Type.PICKAXE, Block.LAYER_FOREGROUND, Vector2(0, 0), "Grassy dirt block"),
	block(Tool.Type.PICKAXE, Block.LAYER_FOREGROUND, Vector2(1, 0), "Dirt block"),
	block(Tool.Type.PICKAXE, Block.LAYER_FOREGROUND, Vector2(2, 0), "Stone block"),
	block(Tool.Type.PICKAXE, Block.LAYER_FOREGROUND, Vector2(4, 0), "Spike block"),
	block(Tool.Type.PICKAXE, Block.LAYER_FOREGROUND, Vector2(5, 0), "Window"),
	block(Tool.Type.HAMMER,  Block.LAYER_BACKGROUND, Vector2(0, 0), "Cave wall")]

var hotbar_selection_index: int = 0

func selected_item() -> Item:
	return hotbar[hotbar_selection_index]

func log_selected_item() -> void:
	print("Currently selected: %s" % selected_item().name)

func change_hotbar_selection(direction: int) -> void:
	hotbar_selection_index = wrapi(hotbar_selection_index + direction, 0, hotbar.size())
	log_selected_item()

func selected_tile_coordinates() -> Vector2:
	return local_to_map(get_global_mouse_position())

class TileProperties:
	var health: int

# Map tile coordinates to tile properties
var tile_properties: Dictionary = {}

func set_default_properties(layer: int, tile: Vector2) -> void:
	var properties = TileProperties.new()
	properties.health = get_cell_tile_data(layer, tile).get_custom_data("block_health")
	tile_properties[tile] = properties

const BLOCK_HIT_INTERVAL: float = 0.25
var block_hit_time: float = 0
var is_holding_down_left_click: bool = false

func tile_exists(layer: int, tile: Vector2) -> bool:
	return get_cell_source_id(layer, tile) != -1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		change_hotbar_selection(1)
	elif event.is_action_pressed("scroll_down"):
		change_hotbar_selection(-1)
	elif event.is_action_pressed("left_click"):
		is_holding_down_left_click = true
	elif event.is_action_released("left_click"):
		is_holding_down_left_click = false
		block_hit_time = BLOCK_HIT_INTERVAL

func _process(delta: float) -> void:
	block_hit_time += delta

	if not is_holding_down_left_click: return

	var callback = Item.UseCallback.new()

	callback.hit_block = func(tool: Tool):
		if block_hit_time < BLOCK_HIT_INTERVAL:
			return
		else:
			block_hit_time = 0

		var tile: Vector2 = selected_tile_coordinates()
		if not tile_exists(tool.layer(), tile):
			return

		if not tile_properties.has(tile):
			set_default_properties(tool.layer(), tile)

		var damage: int = tool.base_damage
		if tool.type != tool_type_for(tool.layer(), tile):
			damage = (damage * 0.33) as int

		tile_properties[tile].health -= damage
		if tile_properties[tile].health <= 0:
			erase_cell(tool.layer(), tile)
			tile_properties.erase(tile)

	callback.place_block = func(block: Block):
		var tile: Vector2 = selected_tile_coordinates()
		if not tile_exists(block.layer, tile):
			set_cell(block.layer, tile, block.source_id(), block.atlas_coords)
			set_default_properties(block.layer, tile)

	selected_item().use(callback)
