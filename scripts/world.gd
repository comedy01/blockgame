extends Node2D

@onready var tile_map = $TileMap
@export var noise_map : Texture2D

const SOURCE_ID = 0
const BLOCK_LAYER = 0
const GRASS_BLOCK_ATLAS = Vector2i(0, 0)
const DIRT_BLOCK_ATLAS = Vector2i(1,0)
const STONE_BLOCK_ATLAS = Vector2i(2,0)
const GRASS_RAMP_RIGHT_ATLAS = Vector2i(10,0)
const GRASS_RAMP_LEFT_ATLAS = Vector2i(11,0)
const WORLD_SIZE = Vector2i(2000, 500)

func get_noise(x: int) -> int:
	return int(noise_map.noise.get_noise_1d(x) * 10)

func set_block(x: int, y: int, atlas: Vector2i) -> void:
	tile_map.set_cell(BLOCK_LAYER, Vector2i(x, y), SOURCE_ID, atlas)

func make_layer_offset() -> int:
	match randi_range(1, 20):
		1:    return randi_range(-3, 3)
		2, 3: return randi_range(-2, 2)
		_:    return randi_range(-1, 1)

func set_grass(x: int, y: int, previous_y: int) -> void:
	match previous_y - y:
		1:
			set_block(x, y, GRASS_RAMP_RIGHT_ATLAS)
		-1:
			set_block(x, y - 1, GRASS_RAMP_LEFT_ATLAS)
			set_block(x, y, DIRT_BLOCK_ATLAS)
		_:
			set_block(x, y, GRASS_BLOCK_ATLAS)

func _ready():
	var stone_y: int = randi_range(1, 20)

	for x in WORLD_SIZE.x:
		var grass_y = get_noise(x)

		stone_y = clamp(stone_y + make_layer_offset(), grass_y - 5, grass_y + 10)
		if stone_y < grass_y: stone_y += randi_range(0, 1)

		# Grass surface
		set_grass(x, grass_y, get_noise(x - 1))

		# Dirt layer
		for y in range(grass_y + 1, stone_y):
			tile_map.set_cell(BLOCK_LAYER, Vector2i(x, y), 0, DIRT_BLOCK_ATLAS)

		# Stone layer
		for y in 30:
			tile_map.set_cell(BLOCK_LAYER, Vector2i(x, stone_y + y), 0, STONE_BLOCK_ATLAS)

func _process(_delta) -> void:
	pass

func is_tile_empty(pos: Vector2i) -> bool:
	return tile_map.get_cell_source_id(BLOCK_LAYER, pos, false) == -1

func get_mouse_tile() -> Vector2i:
	return tile_map.local_to_map(get_global_mouse_position())

func _input(event):
	if event.is_action_pressed("right_click"):
		var tile = get_mouse_tile()
		if is_tile_empty(tile):
			tile_map.set_cell(BLOCK_LAYER, tile, SOURCE_ID, GRASS_BLOCK_ATLAS)

	elif event.is_action_pressed("left_click"):
		tile_map.erase_cell(BLOCK_LAYER, get_mouse_tile())
