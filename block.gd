class_name Block

enum Type { NONE, GRASS, DIRT , STONE }

var health: int
var atlas_coords: Vector2i
var type: Type

func _init(p_health: int, p_atlas_coords: Vector2i, p_type: Type):
	health = p_health
	atlas_coords = p_atlas_coords
	type = p_type
	
