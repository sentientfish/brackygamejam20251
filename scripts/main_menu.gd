extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	get_tree().change_scene_to_file("res://scenes/rest_area.tscn")

func _on_options_button_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	get_tree().change_scene_to_file("res://ui/options.tscn")

func _on_credits_button_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	get_tree().change_scene_to_file("res://ui/credits.tscn")

func _on_quit_button_pressed() -> void:
	$AudioStreamPlayer2D3.play()
	get_tree().quit()


func _on_start_button_mouse_entered() -> void:
	$AudioStreamPlayer2D2.play()



func _on_options_button_mouse_entered() -> void:
	$AudioStreamPlayer2D2.play()



func _on_credits_button_mouse_entered() -> void:
	$AudioStreamPlayer2D2.play()



func _on_quit_button_mouse_entered() -> void:
	$AudioStreamPlayer2D2.play()
