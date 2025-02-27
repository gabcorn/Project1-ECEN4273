extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_node("pauseWindow").visible = true
	get_tree().paused = true # Restart play state


func _on_pause_window_close_requested() -> void:
	get_node("pauseWindow").visible = false
	get_tree().paused = false # Restart play state


func _input(event: InputEvent) -> void:
	if event.is_action("Pause"):
		_on_pressed()
