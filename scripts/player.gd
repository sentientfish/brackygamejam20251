extends CharacterBody2D


const SPEED = 300.0

var can_attack: bool = true
var can_block: bool = true
var can_move: bool = true

# Used to indicate whether that direction is being blocked or not
# 0 is up, 1 is middle, 2 is down
# TODO: have a global variable for each direction?
var blocking: Array = [false, false, false]

func _physics_process(delta: float) -> void:
	process_player_input(delta)

func process_player_input(delta: float) -> void:
	var move_direction := Input.get_axis("move_left", "move_right")
	if move_direction and can_move:
		velocity.x = move_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var action_direction := 1
	if Input.is_action_pressed("target_up"):
		action_direction = 0
	elif Input.is_action_pressed("target_down"):
		action_direction = 2

	if Input.is_action_just_pressed("attack") and can_attack:
		attack(action_direction)
	elif Input.is_action_pressed("block") and can_block:
		block(action_direction)
	
	if Input.is_action_just_released("block") and can_block:
		unblock(action_direction)
	
	move_and_slide()

func attack(action_direction):
	#TODO: Play the actual animations
	can_block = false
	can_move = false
	print("Player attacking direction: " + str(action_direction))
	
	# TODO: play an animation
	# assume animation played here
	# reset states
	can_block = true
	can_move = true

func block(action_direction):
	can_attack = false
	can_move = false
	
	# TODO: Play blocking animation and hold shield there
	print("Player blocking direction: " + str(action_direction))
	
	# Hacky solution to reset the blocking array whenever the block
	# action is rendered
	var updated_blocking_array := [false, false, false]
	updated_blocking_array[action_direction] = true
	blocking = updated_blocking_array

func unblock(action_direction):
	print("Player stopped blocking direction: " + str(action_direction))
	blocking[action_direction] = false
	can_attack = true
	can_move = true
