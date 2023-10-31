extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumps = 0

func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(26, 26)), Color(1, 0, 0), false)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
			
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor():
		jumps = 0

	if Input.is_action_just_pressed("move_up") and (is_on_floor() or jumps < MAX_JUMPS):
		velocity.y = JUMP_VELOCITY
		jumps += 1
		
	move_and_slide()
