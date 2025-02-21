class_name Quickfeet extends Effect

func trigger_effect(character: CharacterBody2D):
	for i in range(0, owned_stacks):
		character.current_speed += 100

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/Quickfeet.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 3
	effect_name = "Quickfeet"
	target_player = true
