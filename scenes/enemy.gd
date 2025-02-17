extends CharacterBody2D

const SPEED = 300.0

# TODO: have a global variable for each direction?
var blocking: Array = [false, false, false]

# temporary dummy movement
var move_direction: int = -1

# Enemy Base Stats
@export var stat_health: float = 300.0
@export var stat_attack: float = 50.0
@export var stat_block_damage: float = 0.0
@export var stat_speed: float = 200.0

# Enemy Current Stats
@export var current_health: float = stat_health
@export var current_attack: float = stat_attack
@export var current_block_damage: float = stat_block_damage
@export var current_speed: float = stat_speed

func _physics_process(delta: float) -> void:
	velocity.x = move_direction * stat_speed
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		move_direction *= -1

func attacked(damage: int, action_direction: Enums.ActionDirection):
	print("Enemy being attacked! damage " + str(damage) + ", direction: " +
		Enums.ActionDirection.keys()[action_direction])
	if (blocking[int(action_direction) - 1]):
		print("Enemy blocked the attack!")
	else:
		print("Enemy hit!")
		current_health -= damage
		print("Current enemy health: " + str(current_health))
		if (current_health <= 0):
			print("Enemy died!")
			queue_free()
