class_name Block

enum Type { NONE, GRASS, DIRT, STONE }

var health: int
var atlas: Vector2i
var type: Type

func _init(p_health: int, p_atlas: Vector2i, p_type: Type) -> void:
	health = p_health
	atlas = p_atlas
	type = p_type
