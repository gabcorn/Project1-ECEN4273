extends Area2D

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


func _on_body_entered(body: Node2D) -> void:
	print("hhhh")
	if (body.name == "Player" or body.name == "Villain") or body.name == "piao":
		print("dddd")
		body.take_damage(2)
