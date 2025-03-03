extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_room():
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1.0, 0.5)  # Fade to black
	await tween.finished
	get_tree().change_scene_to_file("res://NextRoom.tscn")  # Change to your next room scene

func _on_Passage_body_entered(body):
	if body.name == "Player":
		print("You entered the passage!")
		change_room()
