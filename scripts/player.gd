extends CharacterBody2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Used to indicate whether that direction is being blocked or not
# 0 is up, 1 is middle, 2 is down
# TODO: have a global variable for each direction?
var blocking: Array = [false, false, false]
var is_blocking: bool = false

# Player Stats
@export var stat_health: float = 300.0
@export var stat_attack: float = 50.0
@export var stat_block_damage: float = 0.0
@export var stat_speed: float = 300.0

func _physics_process(delta: float) -> void:
	process_player_input(delta)

func process_player_input(delta: float) -> void:
	var is_playing := animation_player.is_playing()
	var move_direction := Input.get_axis("move_left", "move_right")
	if move_direction and not is_playing and not is_blocking:
		velocity.x = move_direction * stat_speed
	else:
		velocity.x = move_toward(velocity.x, 0, stat_speed)

	var action_direction := Enums.ActionDirection.MIDDLE
	if Input.is_action_pressed("target_up"):
		action_direction = Enums.ActionDirection.UP
	elif Input.is_action_pressed("target_down"):
		action_direction = Enums.ActionDirection.DOWN

	if Input.is_action_just_pressed("attack") and not is_playing:
		attack(action_direction)
	elif Input.is_action_just_pressed("block") and not is_playing:
		block(action_direction)
	
	if Input.is_action_just_released("block"):
		unblock(action_direction)
	
	move_and_slide()
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		print("Player collided with: " + body.name)

func attack(action_direction: Enums.ActionDirection):
	print("Player attacking direction: " + str(action_direction))
	# TODO: play an actual animation
	match action_direction:
		Enums.ActionDirection.UP:
			animation_player.play("sword_attack_up")
		Enums.ActionDirection.MIDDLE:
			animation_player.play("sword_attack_middle")
		Enums.ActionDirection.DOWN:
			animation_player.play("sword_attack_down")

func block(action_direction: Enums.ActionDirection):
	# TODO: Play blocking animation and hold shield there
	print("Player blocking direction: " + str(action_direction))
	
	match action_direction:
		Enums.ActionDirection.UP:
			animation_player.play("shield_block_up")
		Enums.ActionDirection.MIDDLE:
			animation_player.play("shield_block_middle")
		Enums.ActionDirection.DOWN:
			animation_player.play("shield_block_down")
	
	is_blocking = true
	var updated_blocking_array := [false, false, false]
	updated_blocking_array[action_direction] = true
	blocking = updated_blocking_array

func unblock(action_direction: Enums.ActionDirection):
	print("Player stopped blocking direction: " + str(action_direction))
	is_blocking = false
	blocking[action_direction] = false
	
	match action_direction:
		Enums.ActionDirection.UP:
			animation_player.play_backwards("shield_block_up")
		Enums.ActionDirection.MIDDLE:
			animation_player.play_backwards("shield_block_middle")
		Enums.ActionDirection.DOWN:
			animation_player.play_backwards("shield_block_down")
	
func attacked(damage: int, action_direction: Enums.ActionDirection):
	print("Player being attacked! damage " + str(damage) + ", direction: " + str(action_direction))
	if blocking[action_direction]:
		print("Blocked the attack!")
	else:
		print("Got hit!")
	
func _on_sword_area_up_body_entered(body: Node2D) -> void:
	body.attacked(stat_attack, Enums.ActionDirection.UP)

func _on_sword_area_middle_body_entered(body: Node2D) -> void:
	body.attacked(stat_attack, Enums.ActionDirection.MIDDLE)

func _on_sword_area_down_body_entered(body: Node2D) -> void:
	body.attacked(stat_attack, Enums.ActionDirection.DOWN)
