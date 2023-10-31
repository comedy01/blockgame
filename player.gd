extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0
const MAX_JUMPS: int = 2

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumps: int = 0

func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), Vector2(26, 26)), Color(1, 0, 0), false)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = SPEED * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))

	if is_on_floor():
		jumps = 0

	if Input.is_action_just_pressed("move_up") and (is_on_floor() or jumps < MAX_JUMPS):
		velocity.y = JUMP_VELOCITY
		jumps += 1

	move_and_slide()
