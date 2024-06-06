extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if Input.is_action_just_pressed("close"):
		get_tree().quit()
	
	if is_on_floor():
		if Input.is_action_just_pressed("move_up"):
			velocity.y += JUMP_VELOCITY
	else:
		if Input.is_action_just_pressed("move_down"):
			velocity.y -= JUMP_VELOCITY
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
