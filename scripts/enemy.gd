class_name Enemy extends CharacterBody2D

# Enemy Signals
signal enemy_died

# Enemy Base Stats
@export var stat_health: float = 300.0
@export var stat_attack: float = 50.0
@export var stat_block_damage: float = 0.0
@export var stat_speed: float = 400.0

# Enemy Current Stats
@export var current_health: float = stat_health
@export var current_attack: float = stat_attack
@export var current_block_damage: float = stat_block_damage
@export var current_speed: float = stat_speed

# Used to indicate whether that direction is being blocked or not
var blocking: Array = [false, false, false]
var can_block: bool = true
var is_blocking: bool = false
var panicking: bool = false
var panic_run_direction: int = 0
var panic_timer: Timer = null
var cornered_block_timer: Timer = null
var block_duration_timer: Timer = null
var last_block_direction: Enums.ActionDirection = Enums.ActionDirection.NONE

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	panic_timer = get_node("PanicRunTimer")
	cornered_block_timer = get_node("CorneredBlockTimer")
	block_duration_timer = get_node("BlockDurationTimer")

func _physics_process(delta: float) -> void:
	var is_playing := animation_player.is_playing()
	if (not is_playing and not is_blocking):
		run_away()

func run_away():
	# Player died
	if (Globals.Player):
		pass
	var enemy_x := position.x
	var player_x := Globals.Player.position.x
	
	var move_direction := 0
	if (not panicking):
		move_direction = 1
		if (enemy_x - player_x < 0):
			move_direction = -1
	else:
		move_direction = panic_run_direction
		
	velocity.x = move_direction * current_speed
	move_and_slide()

func panic() -> int:
	# get the longest distance we can run
	# use that direction to run until panic timer signals
	current_speed *= 2
	var move_direction := 1
	if (position.x > (1920 - position.x)):
		move_direction = -1
	return move_direction

func cornered():
	# randomly blocks
	var block_direction: Enums.ActionDirection = _get_random_direction()
	print("Random block direction: " + str(block_direction))
	
	block(block_direction)
	
func attack(action_direction: Enums.ActionDirection):
	print("Enemy attacking direction: " + 
		Enums.ActionDirection.keys()[action_direction])
	# TODO: play an actual animation
	match action_direction:
		Enums.ActionDirection.UP:
			animation_player.play("sword_attack_up")
		Enums.ActionDirection.MIDDLE:
			animation_player.play("sword_attack_middle")
		Enums.ActionDirection.DOWN:
			animation_player.play("sword_attack_down")

func block(action_direction: Enums.ActionDirection):
	# So, because we have 3 sword areas, this will get called 3x as well
	# but don't worry, the is_blocking sort of functions as a lock, so it will
	# only get triggered once, but if you print it will show 3x so it might
	# get confusing to debug
	if (not is_blocking):
		last_block_direction = action_direction
		match action_direction:
			Enums.ActionDirection.UP:
				animation_player.play("shield_block_up", -1, 2.0)
			Enums.ActionDirection.MIDDLE:
				animation_player.play("shield_block_middle", -1, 2.0)
			Enums.ActionDirection.DOWN:
				animation_player.play("shield_block_down", -1, 2.0)
	
		is_blocking = true
		_update_block_array(action_direction)
		block_duration_timer.start()

func unblock(action_direction: Enums.ActionDirection):
	print("Enemy unblocking!")
	_update_block_array(Enums.ActionDirection.NONE)
	can_block = false
	is_blocking = false
	cornered_block_timer.start()
	last_block_direction = Enums.ActionDirection.NONE
	
	match action_direction:
	# these play() functions are basically play_backwards(), but 4x as fast
		Enums.ActionDirection.UP:
			animation_player.play("shield_block_up", -1, -4.0, true)
		Enums.ActionDirection.MIDDLE:
			animation_player.play("shield_block_middle", -1, -4.0, true)
		Enums.ActionDirection.DOWN:
			animation_player.play("shield_block_down", -1, -4.0, true)

func attacked(damage: int, action_direction: Enums.ActionDirection):
	panicking = true
	print("Enemy being attacked! damage " + str(damage) + ", direction: " +
		Enums.ActionDirection.keys()[action_direction])
	if (blocking[int(action_direction) - 1]):
		print("Enemy blocked the attack!")
		
		# attack back
		var attack_direction: Enums.ActionDirection = _get_random_direction()
		attack(attack_direction)
	else:
		print("Enemy hit!")
		current_health -= damage
		print("Current enemy health: " + str(current_health))
		if (current_health <= 0):
			print("Enemy died!")
			enemy_died.emit()
			queue_free()
	
	# Start PanicRunTimer
	panic_run_direction = panic()
	run_away()
	panic_timer.start()

func _update_block_array(block_direction: Enums.ActionDirection):
	var updated_blocking_array := [false, false, false]
	if (block_direction != Enums.ActionDirection.NONE):	
		updated_blocking_array[int(block_direction) - 1] = true
		
	blocking = updated_blocking_array

func _get_random_direction():
	var random_int = randi() % 2
	var direction: Enums.ActionDirection = \
		Enums.ActionDirection.values()[random_int + 1]
	
	return direction

func _on_enemy_area_area_entered(area: Area2D) -> void:
	# A bit janky, but basically, the Player's 3 SwordArea* are going to enter
	# the EnemyArea. To check if it's the Player's, we climb the tree twice
	# Player -> Sword -> SwordArea*
	if ("player" in area.get_parent().get_parent().name.to_lower()):
		if (not panicking and can_block):
			cornered()

func _on_panic_run_timer_timeout() -> void:
	panic_timer.stop()
	panicking = false
	current_speed = stat_speed

func _on_cornered_block_timer_timeout() -> void:
	cornered_block_timer.stop()
	can_block = true

func _on_block_duration_timer_timeout() -> void:
	block_duration_timer.stop()
	can_block = false
	unblock(last_block_direction)

func _on_sword_area_up_body_entered(body: Node2D) -> void:
	if ("player" in body.name.to_lower()):
		body.attacked(stat_attack, Enums.ActionDirection.UP)

func _on_sword_area_middle_body_entered(body: Node2D) -> void:
	if ("player" in body.name.to_lower()):
		body.attacked(stat_attack, Enums.ActionDirection.MIDDLE)

func _on_sword_area_down_body_entered(body: Node2D) -> void:
	if ("player" in body.name.to_lower()):
		body.attacked(stat_attack, Enums.ActionDirection.DOWN)
