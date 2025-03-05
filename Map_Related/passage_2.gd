extends Area2D

var inTransition = false

var scene = load("res://Map_Related/MainRoom.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inTransition = true
	await get_tree().create_timer(1).timeout
	inTransition = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_room():
	#get_tree().paused = true
	var map = get_parent().get_parent()
	if not inTransition:
		map.get_child(0).global_position = Vector2(20000, 20000)
		#map.inTransition = true
		var instance = scene.instantiate()
		#print(instance.name)
		#print(self)
		#if map.name != "MainRoom":
		#	map = map.get_parent()
		map.get_child(0).global_position = instance.get_child(0).global_position
		#print(map)
		map.add_child(instance)  # Change to your next room scene
		#map.remove_child(self.get_parent())
		self.get_parent().queue_free()
		#map.inTransition = false
		#get_tree().paused = false

#func _on_Passage_body_entered(body):
#	if body.name == "Player":
#		print("You entered the passage!")
#		change_room()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#print("You entered the passage!")
		change_room()
	# Replace with function body.
