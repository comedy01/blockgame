extends GridContainer

func _ready():
	var tilemap_node = get_node("res://scripts/tilemap.gd")
	tilemap_node.connect("update_inventory", self, "_on_update_inventory")

func _on_update_inventory(p_inventory):
	for i in range(min(p_inventory.size(), get_child_count())):
		var item = p_inventory[i]
		var panel = get_child(i)

		if item:
			panel.texture = item.icon_texture
			panel.visible = true

	
