extends Node2D

var DIR = Vector2(0, 0)
var count = 0
# Called when the node enters the scene tree for the first time.
func _init() -> void:
	self.rotation = DIR.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if count == 30:
		self.get_tree().queue_delete(self)
	else:
		count += 1
