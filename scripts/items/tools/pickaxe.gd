class_name Pickaxe extends Item

func _init():
	name = "Pickaxe"

func use(callback: UseCallback) -> void:
	callback.break_block.call(Block.LAYER_FOREGROUND)
