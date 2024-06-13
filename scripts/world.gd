extends Node2D

@onready var tile_map = $TileMap
@export var noise_map_grass : Texture2D
@export var noise_map_dirt : Texture2D
@export var noise_map_caves: Texture2D
@export var noise_map_iron : Texture2D

const SOURCE_ID = 0
const BLOCK_LAYER = 0
const GRASS_BLOCK_ATLAS = Vector2i(0, 0)
const DIRT_BLOCK_ATLAS = Vector2i(1, 0)
const STONE_BLOCK_ATLAS = Vector2i(2, 0)
const GRASS_RAMP_RIGHT_ATLAS = Vector2i(10, 0)
const GRASS_RAMP_LEFT_ATLAS = Vector2i(11, 0)
const IRON_BLOCK_ATLAS = Vector2i(0, 5)
const NONE_BLOCK_ATLAS = Vector2i(-1, -1)
const WORLD_SIZE = Vector2i(2000, 500)

func get_noise_grass(x: int) -> int:
	return int(noise_map_grass.noise.get_noise_1d(x) * 10)

func get_noise_dirt(x, y) -> int:
	return int(noise_map_dirt.noise.get_noise_2d(x, y) * 10)

func get_noise_iron(x: int, y: int) -> int:
	return int(noise_map_iron.noise.get_noise_2d(x, y) * 10)

func set_block(x: int, y: int, atlas: Vector2i) -> void:
	tile_map.set_cell(BLOCK_LAYER, Vector2i(x, y), SOURCE_ID, atlas)

func has_block(x: int, y: int) -> bool:
	return tile_map.get_cell_source_id(BLOCK_LAYER, Vector2i(x, y), false) != -1

func set_grass(x: int, y: int, previous_y: int) -> void:
	match previous_y - y:
		1:
			set_block(x, y, GRASS_RAMP_RIGHT_ATLAS)
		-1:
			set_block(x, y - 1, GRASS_RAMP_LEFT_ATLAS)
			set_block(x, y, DIRT_BLOCK_ATLAS)
		_:
			set_block(x, y, GRASS_BLOCK_ATLAS)

func generate_underground(x: int, y: int, stone_index: int, grass_y: int) -> int:
	var atlas = DIRT_BLOCK_ATLAS if get_noise_dirt(x, y) > stone_index else STONE_BLOCK_ATLAS
	set_block(x, y + grass_y, atlas)

	if (y > 25 and y < 30):
		return -3
	elif (y > 30 and y < 40):
		return -2
	elif (y > 40 and y < 50):
		return -1
	if (y > 50 and y < 60):
		return 0
	elif (y > 60 and y < 70):
		return 1
	elif (y > 70 and y < 80):
		return 2
	elif (y > 80 and y < 90):
		return 3
	else:
		return stone_index

func _ready() -> void:
	for x in WORLD_SIZE.x:
		var stone_index = -4
		var grass_y = get_noise_grass(x)
		for y in 100 - grass_y:
			stone_index = generate_underground(x, y, stone_index, grass_y)
			if (get_noise_iron(x, y) < -4.5 and y > 20):
				set_block(x, y, IRON_BLOCK_ATLAS)

		set_grass(x, grass_y, get_noise_grass(x - 1))

		for y in WORLD_SIZE.y:
			if (noise_map_caves.noise.get_noise_2d(x,y) < -0.7):
				set_block(x, y + grass_y - 1, NONE_BLOCK_ATLAS)

func get_mouse_tile() -> Vector2i:
	return tile_map.local_to_map(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		var tile = get_mouse_tile()
		if !has_block(tile.x, tile.y):
			set_block(tile.x, tile.y, GRASS_BLOCK_ATLAS)

	elif event.is_action_pressed("left_click"):
		var tile = get_mouse_tile()
		set_block(tile.x, tile.y, NONE_BLOCK_ATLAS)
