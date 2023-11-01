class_name Hammer extends Item

func _init():
	name = "Hammer"

func use(callback: UseCallback) -> void:
	callback.break_block.call(Block.LAYER_BACKGROUND)
