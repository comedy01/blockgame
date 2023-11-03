class_name Item extends Object

var name: String

class UseCallback:
	var hit_block: Callable
	var place_block: Callable

# Pure virtual function
func use(_callback: UseCallback) -> void:
	assert(false)
