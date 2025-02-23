class_name TrollsHeart extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	for i in range(0, owned_stacks):
		character.current_health += 100

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/TrollsHeart.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 3
	effect_name = "Troll's Heart"
	target_player = true
