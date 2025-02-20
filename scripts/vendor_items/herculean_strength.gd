class_name HerculeanStrength extends Effect

func trigger_effect(character: CharacterBody2D):
	character.stat_attack += 100

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/herculean_strength.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 3
	effect_name = "Herculean Strength"
