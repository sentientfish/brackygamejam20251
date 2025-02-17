extends CharacterBody2D

const SPEED = 300.0

# TODO: have a global variable for each direction?
var blocking: Array = [false, false, false]

# temporary dummy movement
var move_direction: int = -1

# Enemy stats
@export var stat_health: float = 300.0
@export var stat_attack: float = 50.0
@export var stat_block_damage: float = 0.0
@export var stat_speed: float = 200.0

func _physics_process(delta: float) -> void:
	pass
	#velocity.x = move_direction * stat_speed
	
	#var collision_info = move_and_collide(velocity)
	#if collision_info:
		#move_direction *= -1

func attacked(damage: int, action_direction: Enums.ActionDirection):
	print("Enemy being attacked! damage " + str(damage) + ", direction: " + str(action_direction))
	if blocking[action_direction]:
		print("Blocked the attack!")
	else:
		print("Got hit!")
