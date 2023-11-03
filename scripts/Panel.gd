extends Panel

func _init() -> void:
	visible = false

func _on_pressed() -> void:
	visible = not visible

func _on_resume_pressed() -> void:
	visible = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()
