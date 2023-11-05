extends CharacterBody2D

const JUMP_VELOCITY: float = -400.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumps: int = 0
var max_air_jumps: int = 1

var current_movement_input: int = 0
var max_speed: float = 300

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_right") or event.is_action_released("move_left"):
		current_movement_input += 1
	elif event.is_action_pressed("move_left") or event.is_action_released("move_right"):
		current_movement_input -= 1
	elif event.is_action_pressed("move_up") and (is_on_floor() or jumps < max_air_jumps):
		velocity.y = JUMP_VELOCITY
		jumps += 1

func _physics_process(delta: float) -> void:
	if current_movement_input != 0:
		velocity.x = current_movement_input * max_speed
	else:
		velocity.x = move_toward(velocity.x, 0, max_speed * delta * 10)

	if is_on_floor():
		jumps = 0
	else:
		velocity.y += gravity * delta

	move_and_slide()

func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), Vector2(30, 46)), Color(1, 0, 0), true)
