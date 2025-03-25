extends "res://Character_Related/movement.gd"


#const SPEED = 5.0
var scene = load("res://Character_Related/piao_laser.tscn")
var rng = RandomNumberGenerator.new()
#const JUMP_VELOCITY = -400.0
var time2 = 0
var time1 = 0
var count = 0

func _ready() -> void:
	set_health_bar($Health_Bar)
	generate_random_SSN()
	#update_health_bar()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var dist_vec = get_parent().get_parent().get_node("Player").global_position - self.global_position + Vector2(0,0)
	# var dist = ((dist_vec.x ** 2) + (dist_vec.y ** 2)) ** .5
	#var direction = dist_vec.normalized()
	var direction
	match count:
		0: 
			direction = Vector2(1,1).normalized()
		1: 
			direction = Vector2(-1,1).normalized()
		2: 
			direction = Vector2(-1,-1).normalized()
		3: 
			direction = Vector2(1,-1).normalized()
		_: 
			direction = Vector2(1,1).normalized()
	# var velocity = 0
	time2 = time2 + 1
	var TIME = 0.5 + (self.curr_health / 6) * 0.5
	
	
	#if dist < 400:
	#velocity = direction * 0
	if time2 > time1 + int(TIME / delta):
		var instance = scene.instantiate()
		instance.position = self.position + 100 * direction
		instance.DIR = direction
		self.get_parent().add_child(instance)
		instance._init()
		time1 = time2
	#elif dist < 800:
	#	velocity = direction * SPEED
	#else:
	#	velocity = Vector2(0, 0)
	count = rng.randi() % 4

	move_and_collide(velocity)
