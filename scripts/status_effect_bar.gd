extends Control

var player_status_effect_bar: VBoxContainer = null
var enemy_status_effect_bar: VBoxContainer = null

var player_box_alignment: BoxContainer.AlignmentMode = \
	BoxContainer.AlignmentMode.ALIGNMENT_END
var enemy_box_alignment: BoxContainer.AlignmentMode = \
	BoxContainer.AlignmentMode.ALIGNMENT_BEGIN

var max_effects_in_row := 7 # max number of effects to be shown in a row
var hbox_separator := 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("CombatStarted", _on_combat_started)
	player_status_effect_bar = get_node("PlayerStatusEffectBar")
	enemy_status_effect_bar = get_node("EnemyStatusEffectBar")
	
	player_status_effect_bar.hide()
	enemy_status_effect_bar.hide()
	
	_load_status_effects(player_status_effect_bar, Globals.PlayerStatusEffects,
		player_box_alignment)
	_load_status_effects(enemy_status_effect_bar, Globals.EnemyStatusEffects,
		enemy_box_alignment)

func _load_status_effects(status_effect_bar: VBoxContainer,
		status_effects: Array, alignment: BoxContainer.AlignmentMode):
	var effects := 0
	var hbox_container := _get_new_hbox_container(status_effect_bar, alignment)
		
	for status_effect in status_effects:
		var effect_textrect = TextureRect.new()
		effect_textrect.texture = status_effect.icon
		hbox_container.add_child(effect_textrect)
		
		var children := hbox_container.get_child_count()
		if (children > max_effects_in_row):
			hbox_container = _get_new_hbox_container(status_effect_bar,
				alignment)

func _get_new_hbox_container(vbox_container: VBoxContainer,
		alignment: BoxContainer.AlignmentMode) -> HBoxContainer:
	var hbox_container := HBoxContainer.new()
	hbox_container.alignment = alignment
	
	hbox_container.add_theme_constant_override("separation", hbox_separator)
	
	vbox_container.add_child(hbox_container)
	
	return hbox_container

func _on_combat_started():
	player_status_effect_bar.show()
	enemy_status_effect_bar.show()
