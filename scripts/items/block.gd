class_name Block extends Item

enum { LAYER_FOREGROUND = 1, LAYER_BACKGROUND = 0 }

var atlas_coords: Vector2
var source_id: int
var layer: int

func _init(p_source_id: int, p_atlas_coords: Vector2, p_layer: int, p_name: String):
	source_id = p_source_id
	atlas_coords = p_atlas_coords
	layer = p_layer
	name = p_name

func use(callback: UseCallback) -> void:
	callback.place_block.call(self)
