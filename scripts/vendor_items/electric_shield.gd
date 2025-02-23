class_name ElectricShield extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	for i in range(0, owned_stacks):
		character.block_damage += 50

func _init():
	var texture = load("res://assets/sprites/vendor_items/ElectricShield.png")

	icon = texture
	max_stacks = 3
	effect_name = "Electric Shield"
	target_player = true
