extends CharacterBody2D

signal collided(collider)

@export var SPEED = 10.0
var health_list : Array[TextureRect]
var max_health = 18
var curr_health = 18
var SSN: Array[int] = []
var health_bar
#const JUMP_VELOCITY = -400.0

func _ready() -> void:
	set_health_bar($CanvasLayer/Health_Bar)
	generate_random_SSN()
	$HollandTime.play()
	#timed_damage()

func generate_random_SSN() -> void: # Sets the characters SSN to a random number
	for i in range(9):
		SSN.append(int(randi_range(0,9)))
	
func take_damage(damage: int) -> void:
	if (curr_health - damage) > 0:
		var sfx_array = [$OOF, $HUAGH, $YEOW, $AHHGH]
		# Stop all hurt SFX first
		for sfx in sfx_array:
			sfx.stop()
		var i = randi_range(0, sfx_array.size() - 1)
		sfx_array[i].pitch_scale = randf_range(0.9, 1.1)
		sfx_array[i].play()

		curr_health -= damage
		update_health_bar()
	else:
		curr_health = 0
		update_health_bar()
		die()

func heal_player(inc_health: int) -> void:
	if (curr_health == max_health): # Health already at max
		# Add code to send a signal to not consume healable item
		pass
	elif (curr_health + inc_health) > max_health: # Make sure added health does not exceed max
		print("Here")
		curr_health = max_health
	else: # Increment current health by the amount to be healed by
		curr_health += inc_health
	update_health_bar()

func die() -> void:
	var death_sound := get_node_or_null("PlayerDeathSound")
	if death_sound == null:
		death_sound = get_node_or_null("VillainDeathSound")

	if death_sound:
		print("Playing death sound: ", death_sound.name)
		death_sound.play()
	else:
		print("No death sound found on ", name)

	if self.name.begins_with("Player"):
		await get_tree().create_timer(1.0).timeout
		get_tree().quit()
	else:
		await get_tree().create_timer(1.0).timeout
		get_tree().queue_delete(self)

func set_health_bar(var_health_bar):
	health_bar = var_health_bar

func update_health_bar() -> void:
	print("into update")
	var num_full_hearts = curr_health / 2  # Number of full hearts to end up in the healthbar
	var num_half_hearts = curr_health % 2 # Will be either 0 or 1
	# Dictionary to convert easily between digits of the SSN and sprites in the healthbar
	var HBar_to_SSN = {
		0: 0,
		1: 1,
		2: 2,
		4: 3,
		5: 4,
		7: 5,
		8: 6,
		9: 7,
		10: 8
	}
	
	print("Current Health: ", curr_health)
	if health_bar == null:
		print("Health bar not found")
	var children = health_bar.get_children()
	for i in range(len(children)):
		
		var index = len(children) - 1 - i # Grabs the index from right to left
		
		var child = children[index].get_children()[0]
		#print("Index, Child, Curr_Animation ",index, " ",child.name, " ",child.animation)
		
		if index == 3 or index == 6:
			print("Hyphen")
		elif num_full_hearts == 0 and num_half_hearts == 0: # Set the animation of current node to SSN animation
			if index != 3 && index != 6: # Ensure current character is an asterisk
				var num = SSN[HBar_to_SSN[index]]
				child.play(str(num))
		elif (num_full_hearts > 0):
			num_full_hearts -= 1
			child.play("IdleFull")
		elif num_half_hearts == 1:
			num_half_hearts -= 1
			child.play("IdleHalf")
	print("out of update")

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

	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		var mirror = collider.get_children()[0]
		if mirror.name == "Mirror3":
			mirror.name = "PlayerMirror"
			collider.remove_child(mirror)
			self.get_child(0).add_child(mirror)
			mirror.position = Vector2(50, 0)
			mirror.scale *= 2

func timed_damage():
	var i = 18
	while i > 0:
		take_damage(1)
		await get_tree().create_timer(1.0).timeout
		i -= 1


func _on_passage_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
