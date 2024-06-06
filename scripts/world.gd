extends Node2D

@onready var tile_map = $TileMap
@export var noise_map : Texture2D

const SOURCE_ID = 0
const BLOCK_LAYER = 0
const GRASS_BLOCK_ATLAS = Vector2i(0, 0)

var width = 500

func _ready():
	var noise : FastNoiseLite = noise_map.noise
	for x in width:
		var height = int(noise.get_noise_1d(x) * 10 )
		tile_map.set_cell(BLOCK_LAYER, Vector2(x, height), 0, GRASS_BLOCK_ATLAS)
	
func _process(_delta):
	pass 
	
func is_tile_empty(pos: Vector2i) -> bool:
	return tile_map.get_cell_source_id(BLOCK_LAYER, pos, false) == -1

func get_mouse_tile() -> Vector2i:
	return tile_map.local_to_map(get_global_mouse_position())

func _input(event):
	if event.is_action_pressed("left_click"):
		var mouse_tile = get_mouse_tile()
		if is_tile_empty(mouse_tile):
			tile_map.set_cell(BLOCK_LAYER, mouse_tile, SOURCE_ID, GRASS_BLOCK_ATLAS)
	elif event.is_action_pressed("right_click"):
		tile_map.erase_cell(BLOCK_LAYER, get_mouse_tile())
