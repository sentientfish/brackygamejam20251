extends Node2D

var player_status_effects := []
var enemy_status_effects := []

var rolled_item_string = "You Received\n"

var max_vendor_items := 4
var items := []

var vendor_minigame: Node2D = null
var rolled_item_label: Label = null
var rolled_item_timer: Timer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_generate_vendor_items()
	vendor_minigame = get_node("VendorMinigame")
	rolled_item_label = get_node("RolledItemLabel")
	rolled_item_timer = get_node("RolledItemTimer")
	
	var item_index := 1
	for item in items:
		var item_node := get_node("Item%d" % item_index)
		item_index += 1
		
		item_node.texture = item.icon
	
	vendor_minigame.connect("dice_rolled", _on_dice_rolled)
	rolled_item_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _generate_vendor_items() -> void:
	# TODO: actually randomize it
	
	for i in range(0, max_vendor_items):
		var vendor_item := HerculeanStrength.new()
		
		items.append(vendor_item)

func _on_dice_rolled(dice_1_value, dice_2_value):
	# TODO: actually think about whats a cool way to choose the item
	var rolled_item_index := 0 # temporarily hardcoded
	var rolled_item: Effect = items[rolled_item_index]
	player_status_effects.append(rolled_item)
	
	rolled_item_timer.start()
	rolled_item_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	rolled_item_label.text = ("%s%s" % [rolled_item_string,
		rolled_item.effect_name])
	rolled_item_label.show()

func _on_continue_button_pressed() -> void:
	print("Rest Area Continue Button Pressed!")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _on_rolled_item_timer_timeout() -> void:
	rolled_item_timer.stop()
	rolled_item_label.hide()
