class_name Parrot extends Effect

func trigger_effect(character: CharacterBody2D) -> void:
	Globals.ParrotObtained = true

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/Quickfeet.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 1
	effect_name = "Parrot"
	target_player = true
