extends Control

var game_hud: Control = null 

func _ready() -> void:
	hide()
	game_hud = get_parent()
	game_hud.connect("pause_state_toggled", _on_game_hud_pause_state_toggled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_main_menu_button_pressed() -> void:
	game_hud.paused = false
	
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_options_button_pressed() -> void:
	game_hud.paused = false
	
	get_tree().change_scene_to_file("res://ui/options.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_continue_button_pressed() -> void:
	game_hud.paused = false

func _on_game_hud_pause_state_toggled(paused: bool):
	if (paused):
		show()
	else:
		hide()
