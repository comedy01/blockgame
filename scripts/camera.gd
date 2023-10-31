extends Camera2D

var zoom_speed = 0.02

func _process(delta):
	if Input.is_action_pressed("zoom_in"):
		zoom_in()
	if Input.is_action_pressed("zoom_out"):
		zoom_out()

func zoom_in():
		zoom *= (1.0 + zoom_speed)

func zoom_out():
		zoom /= (1.0 + zoom_speed)
