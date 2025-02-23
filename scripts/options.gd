extends Control

var master_volume_slider: HSlider = null
var bgm_volume_slider: HSlider = null
var sfx_volume_slider: HSlider = null
var mute_check_box: CheckBox = null

var master_bus_index := 0
var bgm_bus_index := 1
var sfx_bus_index := 2

var options_container_string = "OptionsMarginContainer/OptionsVerticalContainer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_volume_slider = get_node(
		"%s/MasterVolumeContainer/MasterVolumeSlider" % \
		options_container_string)
	bgm_volume_slider = get_node("%s/BGMVolumeContainer/BGMVolumeSlider" % \
		options_container_string)
	sfx_volume_slider = get_node("%s/SFXVolumeContainer/SFXVolumeSlider" % \
		options_container_string)
	mute_check_box = get_node("%s/MuteButtonContainer/MuteCheckBox" % \
		options_container_string)
	
	master_volume_slider.set_value(
			AudioServer.get_bus_volume_db(master_bus_index))
	bgm_volume_slider.set_value(
			AudioServer.get_bus_volume_db(bgm_bus_index))
	sfx_volume_slider.set_value(
			AudioServer.get_bus_volume_db(sfx_bus_index))
	mute_check_box.set_pressed(Globals.Muted)
	

func _on_options_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index, value)
	print("master value " + str(value))

func _on_bgm_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm_bus_index, value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, value)

func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	Globals.Muted = mute_check_box.is_pressed()
	for bus_index in range(0, AudioServer.bus_count):
		print("Muting bus #%d" % bus_index)
		AudioServer.set_bus_mute(bus_index, toggled_on)
