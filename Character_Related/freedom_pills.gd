extends CharacterBody2D


const SPEED = 5
var VELOCITY = Vector2(0.0, 0.0)
var DIR = Vector2(0.0, 0.0)
# const JUMP_VELOCITY = -400.0

func _init() -> void:
	self.rotation = DIR.angle()
	VELOCITY = SPEED * DIR
	move_and_collide(VELOCITY)
	

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(VELOCITY)
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Player" or collider.name == "Villain":
			collider.take_damage(3)
		
		self.get_tree().queue_delete(self)
		
			
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
