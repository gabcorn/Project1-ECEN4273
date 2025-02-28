extends CharacterBody2D


const SPEED = 10.0
var health_list : Array[TextureRect]
var max_health = 9
var curr_health = max_health * 2
#const JUMP_VELOCITY = -400.0

func _ready() -> void:
	var health_bar = $CanvasLayer/Health_Bar
	for child in health_bar.get_children():
		health_list.append(child)
	print(health_list)

func take_damage(damage: int) -> void:
	if (curr_health - damage) > 0:
		curr_health -= damage
		update_health_bar()
	else: #(curr_health - damage) <= 0
		die()

func heal_player(inc_health: int) -> void:
	if (curr_health == max_health): # Health already at max
		# Add code to send a signal to not consume healable item
		pass
	elif (curr_health + inc_health) > max_health: # Make sure added health does not exceed max
		curr_health = max_health
	else: # Increment current health by the amount to be healed by
		curr_health += inc_health

func die() -> void:
	# Implement death logic
	pass

func update_health_bar() -> void:
	# TODO: Implement health bar update logic
	# Clear the current health bar
	
	pass

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
