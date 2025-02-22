class_name FoodPoisoning extends Effect

var poison_damage := 0
var poison_timer := 5
var combat_finished := false

func _ready() -> void:
	Globals.connect("EnemyDied", _on_enemy_died)
	Globals.connect("PlayerDied", _on_player_died)

func trigger_effect(character: CharacterBody2D) -> void:
	for i in range(0, owned_stacks):
		poison_damage += 50
		
	while (not combat_finished and character.current_health > 0):
		print("Poison triggered")
		_apply_damage_overtime(character)
		await character.get_tree().create_timer(poison_timer).timeout

func _apply_damage_overtime(character: CharacterBody2D) -> void:
	character.current_health -= poison_damage

func _on_enemy_died() -> void:
	combat_finished = true

func _on_player_died() -> void:
	combat_finished = true

func _init():
	var image = Image.load_from_file("res://assets/sprites/vendor_items/FoodPoisoning.png")
	var texture = ImageTexture.create_from_image(image)
	
	icon = texture
	max_stacks = 3
	effect_name = "Food Poisoning"
	target_player = false
