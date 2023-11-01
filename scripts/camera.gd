extends Camera2D

const ZOOM_SPEED: float = 1.01

func _process(delta: float) -> void:
	if Input.is_action_pressed("zoom_in"):
		zoom *= (ZOOM_SPEED + delta)
	if Input.is_action_pressed("zoom_out"):
		zoom /= (ZOOM_SPEED + delta)
