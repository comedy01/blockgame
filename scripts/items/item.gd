class_name Item extends Object

var name: String
var atlas_coords: Vector2

class UseCallback:
	var hit_block: Callable
	var place_block: Callable

# Pure virtual function
func use(_callback: UseCallback) -> void:
	assert(false)
