extends Camera2D

const ZOOM_SPEED: float = 0.01
var current_zoom_multiplier: float = 1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in") or event.is_action_released("zoom_out"):
		current_zoom_multiplier += ZOOM_SPEED
	elif event.is_action_pressed("zoom_out") or event.is_action_released("zoom_in"):
		current_zoom_multiplier -= ZOOM_SPEED

func _process(_delta: float) -> void:
	zoom *= current_zoom_multiplier
