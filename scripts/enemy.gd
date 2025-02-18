extends CharacterBody2D

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

# TODO: have a global variable for each direction?
var blocking: Array = [false, false, false]
var panicking: bool = false
var panic_run_direction: int = 0
var panic_timer: Timer = null

func _ready():
	panic_timer = get_node("PanicRunTimer")

func _physics_process(delta: float) -> void:
	run_away()

func run_away():
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
	var block_direction: Enums.ActionDirection = Enums.ActionDirection.values()[randi() & 3]
	block(block_direction)
	
func attack(action_direction: Enums.ActionDirection):
	pass

func block(action_direction: Enums.ActionDirection):
	pass

func attacked(damage: int, action_direction: Enums.ActionDirection):
	panicking = true
	print("Enemy being attacked! damage " + str(damage) + ", direction: " +
		Enums.ActionDirection.keys()[action_direction])
	if (blocking[int(action_direction) - 1]):
		print("Enemy blocked the attack!")
		# attack back
	else:
		print("Enemy hit!")
		current_health -= damage
		print("Current enemy health: " + str(current_health))
		if (current_health <= 0):
			print("Enemy died!")
			queue_free()
	
	# Start PanicRunTimer
	panic_run_direction = panic()
	run_away()
	panic_timer.start()

func _on_enemy_area_body_entered(body: Node2D) -> void:
	cornered()

func _on_panic_run_timer_timeout() -> void:
	panic_timer.stop()
	panicking = false
	current_speed = stat_speed
