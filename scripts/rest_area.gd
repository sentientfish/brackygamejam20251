extends Node2D


var rolled_item_string = "You Received\n"
var rolled_item_unavailable_string = "Is no longer available"

var current_item_index := 0
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
	for i in range(0, max_vendor_items):
		# No more available items, just leave
		if (items.size() == Globals.VendorItems.size()):
			break

		var valid := false
		while (not valid):
			var random_item_index := randi() % Globals.VendorItems.size()
			var vendor_item: Effect = Globals.VendorItems[random_item_index]

			if vendor_item in items:
				continue
			else:
				items.append(vendor_item)
				valid = true

func _on_dice_rolled(dice_sum_value):
	var rolled_item_index: int = (current_item_index + dice_sum_value) % \
		items.size()
	var rolled_item: Effect = items[rolled_item_index]
	var rolled_item_text := ""
	if (rolled_item.available):
		rolled_item.append_effect()
		rolled_item_text = ("%s%s" % [rolled_item_string,
			rolled_item.effect_name])
	else:
		rolled_item_text = ("%s%s" % [rolled_item.effect_name,
			rolled_item_unavailable_string])

	rolled_item_timer.start()
	rolled_item_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	rolled_item_label.text = rolled_item_text
	rolled_item_label.show()

	current_item_index = rolled_item_index

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _on_rolled_item_timer_timeout() -> void:
	rolled_item_timer.stop()
	rolled_item_label.hide()
