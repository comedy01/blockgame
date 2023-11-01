class_name Block extends Item

var atlas_coords: Vector2
var source_id: int

func _init(p_source_id: int, p_atlas_coords: Vector2, p_name: String):
	source_id = p_source_id
	atlas_coords = p_atlas_coords
	name = p_name

func use(callback: UseCallback) -> void:
	callback.place_block.call(self)
