extends CharacterBody2D


const SPEED = 5.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dist_vec = get_parent().get_node("Player").global_position - self.global_position
	var dist = ((dist_vec.x ** 2) + (dist_vec.y ** 2)) ** .5
	var direction = dist_vec.normalized()
	var velocity = 0
	
	
	if dist < 400:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0, 0)

	move_and_collide(velocity)
