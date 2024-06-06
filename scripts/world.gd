extends Node2D

@onready var tile_map = $TileMap
@export var noise_map : Texture2D

const SOURCE_ID: int = 0
const BLOCK_LAYER: int = 0
const GRASS_BLOCK_ATLAS = Vector2i(0, 0)
const DIRT_BLOCK_ATLAS = Vector2i(1,0)
const STONE_BLOCK_ATLAS = Vector2i(2,0)

const WORLD_WIDTH: int = 2000
const WORLD_HEIGHT: int = 500

func calculate_stone_offset(current_stone_offset: int, stone_y: int, dirt_height: int) -> int:
	if (dirt_height - 2 > stone_y + current_stone_offset):
		return randi_range(0,3)
	var offset_chance = randi_range(0,100)
	if (offset_chance <= 80):
		return randi_range(-1,1)
	elif (offset_chance > 80 and offset_chance <= 86):
		return -2
	elif (offset_chance > 86 and offset_chance <= 92):
		return 2
	elif (offset_chance > 92 and offset_chance <= 96):
		return -3
	else:
		return 3	

func _ready():
	var noise : FastNoiseLite = noise_map.noise
	var stone_y: int = randi_range(1,20)
	var current_stone_offset = 0
	for x in WORLD_WIDTH:
		var dirt_height = int(noise.get_noise_1d(x) * 10 )
		current_stone_offset = calculate_stone_offset(current_stone_offset, stone_y, dirt_height)
		tile_map.set_cell(BLOCK_LAYER, Vector2(x, dirt_height), 0, GRASS_BLOCK_ATLAS)
		tile_map.set_cell(BLOCK_LAYER, Vector2(x, stone_y + current_stone_offset),0, STONE_BLOCK_ATLAS)
		stone_y += current_stone_offset
		for y in range(dirt_height + 1, stone_y): #fill in gap between stone and grass layer with dirt
			tile_map.set_cell(BLOCK_LAYER, Vector2(x, y), 0, DIRT_BLOCK_ATLAS)
		for y in 30: #chose random stone depth we can adjust later
			tile_map.set_cell(BLOCK_LAYER, Vector2(x,stone_y + y),0, STONE_BLOCK_ATLAS)
	

	
func _process(_delta):
	pass 
	
func is_tile_empty(pos: Vector2i) -> bool:
	return tile_map.get_cell_source_id(BLOCK_LAYER, pos, false) == -1

func get_mouse_tile() -> Vector2i:
	return tile_map.local_to_map(get_global_mouse_position())

func _input(event):
	if event.is_action_pressed("right_click"):
		var mouse_tile = get_mouse_tile()
		if is_tile_empty(mouse_tile):
			tile_map.set_cell(BLOCK_LAYER, mouse_tile, SOURCE_ID, GRASS_BLOCK_ATLAS)
	elif event.is_action_pressed("left_click"):
		tile_map.erase_cell(BLOCK_LAYER, get_mouse_tile())
