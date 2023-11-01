class_name Item extends Object

var name: String

class UseCallback:
	var break_block: Callable
	var place_block: Callable

# Pure virtual function
func use(_callback: UseCallback) -> void:
	# Should be never reached
	assert(false)
