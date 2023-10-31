class_name Block extends Entity

var atlas_coords: Vector2
var source_id: int

func _init(p_source_id: int, p_atlas_coords: Vector2, p_name: String):
	health = 100
	source_id = p_source_id
	atlas_coords = p_atlas_coords
	name = p_name
