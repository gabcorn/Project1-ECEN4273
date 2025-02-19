extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Start_Button.grab_focus() # Allows the start menu settings to be controled via keyboard


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	# get_tree().change_scene("FIRST SCENE PATH HERE")
	pass


func _on_settings_button_pressed() -> void:
	get_node("settingWindow").visible = true # Brings up the settings window


func _on_quit_button_pressed() -> void:
	get_tree().quit() # Quits the game


func _on_setting_window_close_requested() -> void:
	get_node("settingWindow").visible = false # Brings up the settings window
