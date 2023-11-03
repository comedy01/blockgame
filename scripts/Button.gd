extends Button

func _init() -> void:
	visible = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		visible = not visible

func _on_settingsbutton_pressed():
	emit_signal("settings_button_pressed")
