class_name BigBadShield extends Effect

func trigger_effect(character: CharacterBody2D):
	character.block_all = true

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/BigBadShield.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 1
	effect_name = "Big Bad Shield"
	target_player = true
