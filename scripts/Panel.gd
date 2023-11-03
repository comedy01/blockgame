extends Panel

func _init() -> void:
	self.visible = false

func _on_pressed():
	self.visible = not self.visible

func _on_resume_pressed():
	self.visible = false 

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		self.visible = false

func _on_quit_pressed():
	get_tree().quit()
