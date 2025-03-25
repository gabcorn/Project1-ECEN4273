extends Area2D

var inTransition = false

var names = {
	"FanRoom" : "EastPassage", 
	"LannanRoom" : "WestPassage",
	"PiaoRoom" : "NorthPassage",
	"StineRoom" : "SouthPassage"
	}

var scene = load("res://Game_Logic_and_UI/end_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inTransition = true
	await get_tree().create_timer(1).timeout
	inTransition = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_room(body):
	#get_tree().paused = true
	var map = get_parent().get_parent()
	if not inTransition:
		body.scale *=2
		body.get_child(0).remove_child(body.get_child(0).get_child(0))
		body.SPEED *= 1.25
		#map.get_child(0).global_position = Vector2(20000, 20000)
		#map.inTransition = true
		var instance = scene.instantiate()
		#print(instance.name)
		#print(self)
		#if map.name != "MainRoom":
		#	map = map.get_parent()
		
		#map.get_child(0).global_position = instance.get_child(0).global_position
		#print(map)
		map.defeated[self.get_parent().name] = true
		#for x in instance.get_children():
		#	for y in map.defeated:
		#		if x.name == names[y] && map.defeated[y]:
		#			x.queue_free
		for y in map.defeated:
			if map.defeated[y]:
				for x in instance.get_children():
					if x.name == names[y]:
						x.queue_free()
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
		# body.scale *=2
		# body.get_child(0).remove_child(body.get_child(0).get_child(0))
		# print("You entered the passage!")
		change_room(body)
	# Replace with function body.
