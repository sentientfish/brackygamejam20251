class_name TrollsHeart extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	for i in range(0, owned_stacks):
		character.current_health += 100

func _init():
	var texture = load("res://assets/sprites/vendor_items/TrollsHeart.png")

	icon = texture
	max_stacks = 3
	effect_name = "Troll's Heart"
	target_player = true
