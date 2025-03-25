extends Node2D
# Holds global variables
var inTransition = false
var defeated = {
	"PiaoRoom" : false,
	"FanRoom" : false,
	"LannanRoom" : false,
	"StineRoom" : false
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var count = 0
	for x in defeated.values():
		if x:
			count += 1
	if count == 4:
		get_tree().quit()
