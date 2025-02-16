extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_options_back_button_pressed() -> void:
	print("Options Back Button clicked!")
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	print("Options Mute Checkbox toggled!")
	for bus_index in range(0, AudioServer.bus_count):
		print("Muting audio bus #" + str(bus_index) + ": " + AudioServer.get_bus_name(bus_index))
		AudioServer.set_bus_mute(bus_index, true)
