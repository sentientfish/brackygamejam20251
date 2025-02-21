extends Node2D

var win_timer: Timer = null
var victory_label: Label = null

var victory_string = "Victory!!!\nReturning to Rest Area in\n"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_timer = get_node("WinTimer")
	victory_label = get_node("VictoryLabel")
	victory_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	victory_label.hide()
	
	Globals.Enemy.connect("enemy_died", _on_enemy_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	victory_label.text = ("%s%d" % [victory_string, int(win_timer.time_left)])

func _on_win_timer_timeout() -> void:
	# We win, go to rest area!
	win_timer.stop()
	get_tree().change_scene_to_file("res://scenes/rest_area.tscn")

func _on_enemy_died() -> void:
	# We win, start win timer before moving to new area
	victory_label.show()
	win_timer.start()
