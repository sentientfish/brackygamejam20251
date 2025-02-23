extends Node2D

var parrot_sfx_player: AudioStreamPlayer2D = null
var parrot_sfx_timer: Timer = null

var _min_sfx_timer := 2.5
var _max_sfx_timer := 6.0

const PARROT_VICTORY_VOICELINE_PATH := \
		"res://assets/sounds/ParrotSquakVictory.wav"

var _parrot_voicelines = [
	preload("res://assets/sounds/ParrotSquakOne.wav"),
	preload("res://assets/sounds/ParrotSquakTwo.wav"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parrot_sfx_player = get_node("ParrotSFXPlayer")
	parrot_sfx_timer = get_node("ParrotSFXTimer")
	
	Globals.connect("EnemyDied", _on_enemy_died)
	Globals.connect("PlayerDied", _on_player_died)
	
func start_parrot() -> void:
	_prepare_parrot()
	parrot_sfx_timer.start()

func _prepare_parrot() -> void:
	_select_random_parrot_voiceline()
	_set_random_time()

func _set_random_time() -> void:
	var random_timer_value := randf_range(_min_sfx_timer, _max_sfx_timer)
	parrot_sfx_timer.set_wait_time(random_timer_value)
	
func _select_random_parrot_voiceline():
	var random_voiceline_index = randi() % _parrot_voicelines.size()
	parrot_sfx_player.stream = _parrot_voicelines[random_voiceline_index]

func _on_enemy_died() -> void:
	parrot_sfx_timer.stop()
	
	parrot_sfx_player.stream = preload(PARROT_VICTORY_VOICELINE_PATH)
	parrot_sfx_player.play()

func _on_player_died() -> void:
	parrot_sfx_timer.stop()

func _on_parrot_sfx_timer_timeout() -> void:
	parrot_sfx_timer.stop()
	parrot_sfx_player.play()
	await parrot_sfx_player.finished
	
	_prepare_parrot()
	parrot_sfx_timer.start()
