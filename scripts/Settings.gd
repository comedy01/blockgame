extends Button

func _init() -> void:
	visible = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		visible = not visible

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/menu_scene.tscn")
