extends Node2D

var dice_1: Node2D = null
var dice_2: Node2D = null
var dice_roll_exhausted_label: Label = null

var max_dice_rolls := 3
var remaining_dice_rolls := max_dice_rolls

signal dice_rolled(dice_sum_value)

var dice_enum_map = {
	Enums.DiceFace.ONE: "res://assets/sprites/die_1.png",
	Enums.DiceFace.TWO: "res://assets/sprites/die_2.png",
	Enums.DiceFace.THREE: "res://assets/sprites/die_3.png",
	Enums.DiceFace.FOUR: "res://assets/sprites/die_4.png",
	Enums.DiceFace.FIVE: "res://assets/sprites/die_5.png",
	Enums.DiceFace.SIX: "res://assets/sprites/die_6.png",
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dice_1 = get_node("Panel/Dice1")
	dice_2 = get_node("Panel/Dice2")
	dice_1.position.x = -200
	dice_2.position.x = -200
	dice_roll_exhausted_label = get_node("Panel/DiceRollExhaustedLabel")
	dice_roll_exhausted_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func roll_dice(dice: Node2D):
	var random_int = randi() % 2
	var direction : Enums.ActionDirection = \
		Enums.ActionDirection.values()[random_int + 1]

	var dice_roll = randi() % 5
	var dice_face: Enums.DiceFace = Enums.DiceFace.values()[dice_roll]
	var dice_face_png = dice_enum_map[dice_face]

	var image = Image.load_from_file(dice_face_png)
	var texture = ImageTexture.create_from_image(image)

	dice.texture = texture
	dice.set_meta("value", (dice_roll + 1))

func _on_dice_roll_button_pressed() -> void:
	dice_1.position.x = -200
	dice_2.position.x = -200
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(dice_1, "position", Vector2(randi() % 400, dice_1.position.y), 2.0).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(dice_1, "rotation_degrees", dice_1.rotation_degrees + randi() % 360, 2.0)
	tween.tween_property(dice_2, "position", Vector2(randi() % 720, dice_2.position.y), 2.0).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(dice_2, "rotation_degrees", dice_2.rotation_degrees + randi() % 360, 2.0)
	$AudioStreamPlayer2D.play()
	roll_dice(dice_1)
	roll_dice(dice_2)
	remaining_dice_rolls -= 1

	var dice_sum_value: int = dice_1.get_meta("value") + dice_2.get_meta("value")

	dice_rolled.emit(dice_sum_value)

	if (remaining_dice_rolls == 0):
		dice_roll_exhausted_label.show()

		var dice_roll_button := get_node("Panel/DiceRollButton")
		dice_roll_button.disabled = true
