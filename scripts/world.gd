extends Node2D

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
