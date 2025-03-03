extends CharacterBody2D


const SPEED = 10.0
#const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	##no gravity for top down
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * SPEED

		
	move_and_collide(velocity)
	

		
