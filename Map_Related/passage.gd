extends Area2D

var inTransition  = false

var scene = {
	"EastPassage": load("res://Map_Related/FanRoom.tscn"),
	"WestPassage": load("res://Map_Related/LannanRoom.tscn"),
	"NorthPassage": load("res://Map_Related/PiaoRoom.tscn"),
	"SouthPassage": load("res://Map_Related/StineRoom.tscn"),
	}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inTransition = true
	await get_tree().create_timer(1).timeout
	inTransition = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_room(roomName, body):
	#get_tree().paused = true
	var map = get_parent().get_parent()
	if not inTransition:
		body.scale *= 0.5
		body.SPEED *= 0.8
		#map.get_child(0).global_position = Vector2(20000, 20000)
		#map.inTransition = true
		var instance = scene[roomName].instantiate()
		if roomName == "EastPassage":
			#instance.get_children()[-1].SPEED = 0.0
			instance.get_children()[-1].shoot_dist = 1000.0
		#print(instance.name)
		#print(self)
		#if map.name != "MainRoom":
		#	map = map.get_parent()
		map.get_child(0).global_position = instance.get_child(1).global_position
		#print(map)
		map.add_child(instance)  # Change to your next room scene
		#map.remove_child(self.get_parent())
		self.get_parent().queue_free()
		#map.inTransition = false
		#get_tree().paused = false

#func _on_Passage_body_entered(body):
#	if body.name == "Player":
#		print("You entered the passage!!")
#		print(self)
#		change_room()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#body.scale *= 0.5
		#print("You entered the passage!")
		#print(self.name)
		change_room(self.name, body)
	# Replace with function body.
