extends Control

signal pause_state_toggled(paused: bool)

var paused: bool = false:
	get:
		return paused
	set(new_value):
		paused = new_value
		get_tree().paused = paused
		pause_state_toggled.emit(paused)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pause_menu_button_pressed() -> void:
	paused = not paused
