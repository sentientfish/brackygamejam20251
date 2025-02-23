class_name ShoulderParrot extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	character.parrot_obtained = true

func _init():
	var texture = load("res://assets/sprites/vendor_items/ShoulderParrot.png")

	icon = texture
	max_stacks = 1
	effect_name = "Parrot"
	target_player = true
