class_name Tool extends Item

func _init():
	name = "Pickaxe"

func use(callback: UseCallback) -> void:
	callback.break_block.call()
