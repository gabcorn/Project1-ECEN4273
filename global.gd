extends Node

signal player_collided

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.player_collided.connect(_on_global_collision)
	pass # Replace with function body.

func _on_global_collision():
	var player = $Player
	player.take_damage(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
