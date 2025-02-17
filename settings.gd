extends Node2D

# This file cannot handle keyboard inputs yet.

# Use https://docs.godotengine.org/en/latest/classes/class_%40globalscope.html#enum-globalscope-key
# to see enumerations for specific keys
var keyList = { #!INCOMPLETE!
	# These values will eventually be updated so that they grab the current keybinds
	"Up Button" : KEY_UP,
	"Down Button" : KEY_DOWN,
	"Left Button" : KEY_LEFT,
	"Right Button" : KEY_RIGHT
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_return_pressed() -> void:
	get_node("Label").get_parent().get_parent().visible = false


func _on_save_pressed() -> void: #!INCOMPLETE!
	#code to save dictionary values for buttons to the KeybindMap
	_on_return_pressed()


func _on_right_button_pressed() -> void:
	var button = "Right Button"
	_edit_button_val(button)


func _on_left_button_pressed() -> void:
	var button = "Left Button"
	_edit_button_val(button)


func _on_down_button_pressed() -> void:
	var button = "Down Button"
	_edit_button_val(button)


func _on_up_button_pressed() -> void:
	var button = "Up Button"
	_edit_button_val(button)

# Function will allow user to input new key binding, then save it in the keyList dictionary.
# param _button refers to the key value, should map directly to the dictionary.
func _edit_button_val(_button) -> void: #!INCOMPLETE!
	pass
		
