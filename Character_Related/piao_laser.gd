extends CharacterBody2D

var scene = load("res://Character_Related/piao_laser_texture.tscn")

const SPEED = 50
var VELOCITY = Vector2(0.0, 0.0)
var DIR = Vector2(0.0, 0.0)
var count = 0
# const JUMP_VELOCITY = -400.0

func _init() -> void:
	change_dir()	


func change_dir() -> void:
	self.rotation = DIR.angle()
	VELOCITY = SPEED * DIR
	move_and_slide()
	


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(VELOCITY)
	var instance = scene.instantiate()
	instance.position = self.position
	instance.DIR = self.DIR
	self.get_parent().add_child(instance)
	instance._init()
	if collision:
		var collider = collision.get_collider()
		if (collider.name == "Player" or collider.name == "Villain") or collider.name == "piao":
			collider.take_damage(6)
			self.get_tree().queue_delete(self)
		else:
			print(collider.name)
			if collider.name.begins_with("H"):
				DIR = DIR * Vector2(1, -1)
			else:
				DIR = DIR * Vector2(-1, 1)
				print("f")
			change_dir()
			self.position = self.position + DIR * 10
			if count < 7:
				count += 1
			else:
				self.get_tree().queue_delete(self)
			
		
		#self.get_tree().queue_delete(self)
		
			
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
