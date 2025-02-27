extends HBoxContainer

@export var max_health: int = 9
@export var curr_health: int = max_health * 2
@onready var asterisk_scene = preload("res://asterisk.tscn")
@onready var hyphen_scene = preload("res://hyphen.tscn")

var heart_nodes = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initiliaze_healthbar()
	update_healthbar()

func initiliaze_healthbar() -> void:
	for i in range(max_health):
		var asterisk = asterisk_scene.instantiate()
		add_child(asterisk)
		heart_nodes.append(asterisk)

func set_health(health: int) -> void:
	curr_health = clamp(health, 0, max_health * 2)
	update_healthbar()

func update_healthbar() -> void:
	var num_full_hearts = curr_health / 2
	var num_half_hearts = curr_health % 2
	
	for i in range(max_health):
		var curr_animated_sprite = heart_nodes[i] as AnimatedSprite2D
		
		if curr_animated_sprite:
			if i < num_full_hearts:
				if curr_animated_sprite.animation != "IdleFull":
					curr_animated_sprite.play("IdleFull")
			elif i == num_full_hearts and num_half_hearts == 1:
				if curr_animated_sprite.animation != "IdleHalf":
					curr_animated_sprite.play("IdleHalf")
			else:
				if curr_animated_sprite.animation != "IdleEmpty":
					curr_animated_sprite.play("IdleEmpty")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
