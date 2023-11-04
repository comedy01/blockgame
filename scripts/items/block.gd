class_name Block extends Item

enum { LAYER_FOREGROUND = 1, LAYER_BACKGROUND = 0 }

var layer: int
var atlas_coords: Vector2

func _init(p_layer: int, p_atlas_coords: Vector2, p_name: String):
	layer = p_layer
	atlas_coords = p_atlas_coords
	name = p_name

func use(callback: UseCallback) -> void:
	callback.place_block.call(self)

func source_id() -> int:
	return 0 if layer == LAYER_FOREGROUND else 1
