class_name Excalibur extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	character.current_attack += 300

func _init():
	var texture = load("res://assets/sprites/vendor_items/Excalibur.png")

	icon = texture
	max_stacks = 1
	effect_name = "Excalibur"
	target_player = true
