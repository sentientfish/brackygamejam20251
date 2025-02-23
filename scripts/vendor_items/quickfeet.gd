class_name Quickfeet extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	for i in range(0, owned_stacks):
		character.current_speed += 100

func _init():
	var texture = load("res://assets/sprites/vendor_items/Quickfeet.png")

	icon = texture
	max_stacks = 3
	effect_name = "Quickfeet"
	target_player = true
