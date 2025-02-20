extends Node2D

var dice_1: Node2D = null
var dice_2: Node2D = null

var max_dice_rolls := 3
var remaining_dice_rolls := max_dice_rolls

signal dice_rolled(dice_1_value, dice_2_value)

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
	if (remaining_dice_rolls > 0):
		roll_dice(dice_1)
		roll_dice(dice_2)
		
		dice_rolled.emit(dice_1.get_meta("value"), dice_2.get_meta("value"))
