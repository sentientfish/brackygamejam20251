class_name Excalibur extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	character.current_attack += 300

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/Excalibur.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 1
	effect_name = "Excalibur"
	target_player = true
