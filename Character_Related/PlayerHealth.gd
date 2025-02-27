extends Node

@export var max_health: float = 18.0
@onready var curr_health: float = max_health

@onready var health_bar: ProgressBar
signal health_changed(new_health: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_changed.connect(_on_health_changed)

# Called when the health of the character needs to be decreased
# Should only be in increments of .5
func remove_health(damage_amount: float) -> void:
	curr_health = max(curr_health - damage_amount, 0) # Ensures health doesn't go below 0
	if curr_health < 0:
		die() # player dies and game is over
	health_changed.emit(curr_health)

# Called when the health of the character needs to be increased
# Should only be in increments of .5
func add_health(added_amount: float) -> void:
	if curr_health == max_health:
		# Find some way to not use healing item
		pass
	curr_health = min(curr_health + added_amount, max_health)
	health_changed.emit(curr_health)

# Called anytime the health is changed to update the UI
func _on_health_changed(new_health: float) -> void:
	pass
	
# Called when the player has died. Represents one of the end conditions.
func die() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
