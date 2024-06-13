extends Camera2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		if (self.zoom < Vector2(2, 2)):
			self.zoom += Vector2(0.1, 0.1)
	elif event.is_action_pressed("zoom_out"):
		if (self.zoom > Vector2(0.6, 0.6)):
			self.zoom -= Vector2(0.1, 0.1)
