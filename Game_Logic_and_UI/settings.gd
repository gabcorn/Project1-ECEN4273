extends Node2D

# This file handles key changes for up, down, left, and right. It also handles a volume slider.
# Keybindings can be reset to the values from before the user entered the scene, volume slider
# can not be reset in the same way. This file works contigently based on the names of the key
# bindings for "Up", "Down", "Left", and "Right". If they are differnt values, the dictionaries
# keyList and keyChange must be edited accordingly.

# Use https://docs.godotengine.org/en/latest/classes/class_%40globalscope.html#enum-globalscope-key
# to see enumerations for specific keys, the dictionary stores event types
# Actions are initialized to up, down, left, right, check input map
var keyList = { 
	# These values will eventually be updated so that they grab the current keybinds
	"Up" : InputMap.action_get_events("Up")[0],
	"Down" : InputMap.action_get_events("Down")[0],
	"Left" : InputMap.action_get_events("Left")[0],
	"Right" : InputMap.action_get_events("Right")[0]
}

# Tracks if a key needs to change, set to true on key change button press
# Reset to false once the next press input is detected.
var keyChange = {
	"Up" : false,
	"Down" : false,
	"Left" : false,
	"Right" : false
}

# Tracks number of inputs sice the last press of a key change button
var i = 0

# Called when the node enters the scene tree for the first time.
# Sets the keys to the proper names, sets the volume slider to the correct value
func _ready() -> void:
	_set_keys()
	get_node("Label/GridContainer3/VolumeSlider").value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))

# Used by many functions, bases the visual button names off of the keyList dictionary events
func _set_keys() -> void:
	for key in keyList:
		get_node("Label/GridContainer/" + key + "Button").set_text(keyList[key].as_text())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#Unused
func _process(delta: float) -> void:
	pass

# Does not save keybindings, returns user to previous meny
func _on_return_pressed() -> void:
	# Code resets the keyList array and rests the key visuals
	for key in keyList:
		keyList[key] = InputMap.action_get_events(key)[0]
	_set_keys()
	get_node("Label").get_parent().get_parent().visible = false

# Activates if the user presses the Save Keybindings button
# Saves all current keybindings to the Input Map.
# Returns user to previous menu
func _on_save_pressed() -> void: #!INCOMPLETE!
	# code to save dictionary values for buttons to the KeybindMap
	for key in keyList:
		InputMap.action_erase_events(key)
		InputMap.action_add_event(key, keyList[key])
	#_set_keys() ensures that the visual is up to date
	_set_keys()
	# sets the settings menu to invisible again
	get_node("Label").get_parent().get_parent().visible = false

# Indicates right key needs to be changed
func _on_right_button_pressed() -> void:
	keyChange["Right"] = true
	get_node("Label/GridContainer/" + "Right" + "Button").set_text("> <")
	i=0

# Indicates left key needs to be changed
func _on_left_button_pressed() -> void:
	keyChange["Left"] = true
	get_node("Label/GridContainer/" + "Left" + "Button").set_text("> <")
	i=0

# Indicates down key needs to be changed
func _on_down_button_pressed() -> void:
	keyChange["Down"] = true
	get_node("Label/GridContainer/" + "Down" + "Button").set_text("> <")
	i=0

# Indicates up key needs to be changed
func _on_up_button_pressed() -> void:
	keyChange["Up"] = true
	get_node("Label/GridContainer/" + "Up" + "Button").set_text("> <")
	i=0
	

# Function will allow user to input new key binding, then save it in the keyList dictionary.
# Function will activate after any event, broken up by an if and elif for different execution lines
# If it detects a valid key press, the function will reset the keys visually to match new inputs
func _input(event):
	# If the input event is a key press, check to see if any keys need to be updated
	if event is InputEventKey:
		for key in keyChange:
			if keyChange[key]:
				keyList[key] = event
				keyChange[key] = false
		_set_keys()
	# Activates if there is a none key input after the initial clicking of a button
	# Indicates the user did not want to change their key input
	elif i > 0:
		if event.is_pressed():
			for key in keyChange:
				keyChange[key] = false
			_set_keys()
	i = i + 1

# Changes the value of the Master audio bus depending on the slider value for Volume
func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(get_node("Label/GridContainer3/VolumeSlider").value))
