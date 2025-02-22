class_name FoodPoisoning extends Effect

var poison_damage := 0
var poison_timer := 5

func trigger_effect(character: CharacterBody2D):
	for i in range(0, owned_stacks):
		poison_damage += 50
		
	while (character.current_health > 0):
		print("Poison triggered")
		_apply_damage_overtime(character)
		await character.get_tree().create_timer(poison_timer).timeout

func _apply_damage_overtime(character: CharacterBody2D):
	character.current_health -= poison_damage
	print("Enemy health: " + str(character.current_health))

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/FoodPoisoning.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 3
	effect_name = "Food Poisoning"
	target_player = false
