class_name BigBadShield extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	character.block_all = true

func _init():
	var texture = load("res://assets/sprites/vendor_items/BigBadShield.png")

	icon = texture
	max_stacks = 1
	effect_name = "Big Bad Shield"
	target_player = true
