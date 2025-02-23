extends Control

var main_menu_bgm_player: AudioStreamPlayer2D = null
var main_menu_hover_sfx_player: AudioStreamPlayer2D = null
var main_menu_click_sfx_player: AudioStreamPlayer2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_bgm_player = get_node("MainMenuBGMPlayer")
	main_menu_hover_sfx_player = get_node("MainMenuHoverSFXPlayer")
	main_menu_click_sfx_player = get_node("MainMenuClickSFXPlayer")
	
	Globals.PlayerStatusEffects = []
	Globals.EnemyStatusEffects = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	main_menu_click_sfx_player.play()
	get_tree().change_scene_to_file("res://scenes/rest_area.tscn")

func _on_options_button_pressed() -> void:
	main_menu_click_sfx_player.play()
	get_tree().change_scene_to_file("res://ui/options.tscn")

func _on_credits_button_pressed() -> void:
	main_menu_click_sfx_player.play()
	get_tree().change_scene_to_file("res://ui/credits.tscn")

func _on_quit_button_pressed() -> void:
	main_menu_click_sfx_player.play()
	get_tree().quit()

func _on_start_button_mouse_entered() -> void:
	main_menu_hover_sfx_player.play()

func _on_options_button_mouse_entered() -> void:
	main_menu_hover_sfx_player.play()

func _on_credits_button_mouse_entered() -> void:
	main_menu_hover_sfx_player.play()

func _on_quit_button_mouse_entered() -> void:
	main_menu_hover_sfx_player.play()
