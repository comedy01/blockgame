extends Node2D

@onready var tile_map = $TileMap

var BLOCK_LAYER : int = 0
var SOURCE_ID : int = 0
var EMPTY_CELL = -1

func _ready():
	pass
	
func _process(delta):
	pass

func is_tile_empty(mouse_cell_position : Vector2i) -> bool:
	var cell_id = tile_map.get_cell_source_id(BLOCK_LAYER, mouse_cell_position, false)
	return cell_id == -1


func _input(event):
	if Input.is_action_just_pressed("leftclick"):
		var mouse_position : Vector2 = get_global_mouse_position()
		var mouse_cell_position : Vector2i = tile_map.local_to_map(mouse_position)
		if is_tile_empty(mouse_cell_position):
			var atlas_coords : Vector2i = Vector2i(0,0) #grass block atlas hcoords for now, can add block changing later
			tile_map.set_cell(BLOCK_LAYER, mouse_cell_position, SOURCE_ID, atlas_coords)
	
	elif Input.is_action_just_pressed("rightclick"):
		var mouse_position : Vector2 = get_global_mouse_position()
		var mouse_cell_position : Vector2i = tile_map.local_to_map(mouse_position)
		tile_map.erase_cell(BLOCK_LAYER, mouse_cell_position)
