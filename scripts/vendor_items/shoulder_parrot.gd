class_name ShoulderParrot extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	character.parrot_obtained = true

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/ShoulderParrot.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 1
	effect_name = "Parrot"
	target_player = true
