extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("close"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("left_click"):
		$AnimationPlayer.play("swing_tool")
	if Input.is_action_just_released("left_click"):
		$AnimationPlayer.play("idle")
		
	
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
