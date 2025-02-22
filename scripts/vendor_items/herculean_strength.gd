class_name HerculeanStrength extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	for i in range(0, owned_stacks):
		character.current_attack += 50

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/HerculeanStrength.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 3
	effect_name = "Herculean Strength"
	target_player = true
