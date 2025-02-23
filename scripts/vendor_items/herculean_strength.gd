class_name HerculeanStrength extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	for i in range(0, owned_stacks):
		character.current_attack += 50

func _init():
	var texture = load("res://assets/sprites/vendor_items/HerculeanStrength.png")

	icon = texture
	max_stacks = 3
	effect_name = "Herculean Strength"
	target_player = true
