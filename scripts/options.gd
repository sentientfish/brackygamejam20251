extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_options_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	for bus_index in range(0, AudioServer.bus_count):
		AudioServer.set_bus_mute(bus_index, toggled_on)
