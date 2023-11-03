class_name Tool extends Item

enum Type { HAMMER, AXE, PICKAXE, SHOVEL }

var type: Type
var base_damage: int

func _init(p_type: Type, p_base_damage: int, p_name: String):
	type = p_type
	base_damage = p_base_damage
	name = p_name

func use(callback: UseCallback) -> void:
	callback.hit_block.call(self)

func layer() -> int:
	return Block.LAYER_BACKGROUND if type == Type.HAMMER else Block.LAYER_FOREGROUND
