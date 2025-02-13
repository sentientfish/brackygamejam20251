extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	print("Start Button Pressed!")


func _on_options_button_pressed() -> void:
	print("Options Button Pressed!")


func _on_credits_button_pressed() -> void:
	print("Credits Button Pressed!")


func _on_quit_button_pressed() -> void:
	print("Quit Button Pressed!")
	get_tree().quit()
