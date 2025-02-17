extends Control

@onready var die1 = $DieFace
@onready var die2 = $DieFace2

func get_random_die():
	var random = randi_range(1,6)
	var file_path = "res://assets/sprites/die_"+str(random)+".png"
	print(file_path)
	var image = Image.load_from_file(file_path)
	var texture = ImageTexture.create_from_image(image)
	return texture


func _ready() -> void:
	randomize()
	die1.texture = get_random_die()
	die2.texture = get_random_die()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
