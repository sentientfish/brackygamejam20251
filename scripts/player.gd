class_name Player extends CharacterBody2D

# Player Base Stats
@export var stat_health: float = 300.0
@export var stat_attack: float = 50.0
@export var stat_block_damage: float = 0.0
@export var stat_speed: float = 450.0

# Player Current Stats
@export var current_health: float = stat_health
@export var current_attack: float = stat_attack
@export var current_block_damage: float = stat_block_damage
@export var current_speed: float = stat_speed

# Used to indicate whether that direction is being blocked or not
var blocking: Array = [false, false, false]
var is_blocking: bool = false
var block_all: bool = false
var parrot_obtained: bool = false
var current_block_direction: Enums.ActionDirection = Enums.ActionDirection.NONE
var player_attacked_sfx_player: AudioStreamPlayer2D = null
var parrot: Node2D = null

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Globals.Player = self
	player_attacked_sfx_player = get_node("PlayerAttackedSFXPlayer")
	parrot = get_node("Parrot")

	# Trigger all effects on player
	for effect in Globals.PlayerStatusEffects:
		effect.trigger_effect(self)

	if (parrot_obtained):
		parrot.show()
		parrot.start_parrot()
	else:
		parrot.hide()

func _physics_process(delta: float) -> void:
	process_player_input(delta)
	_check_death()

func process_player_input(delta: float) -> void:
	var is_playing := animation_player.is_playing()
	var move_direction := Input.get_axis("move_left", "move_right")
	if (move_direction and not is_playing and not is_blocking):
		velocity.x = move_direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	var action_direction := Enums.ActionDirection.MIDDLE
	if (Input.is_action_pressed("target_up")):
		action_direction = Enums.ActionDirection.UP
	elif (Input.is_action_pressed("target_down")):
		action_direction = Enums.ActionDirection.DOWN

	if (Input.is_action_just_pressed("attack") and not is_playing):
		attack(action_direction)
	elif (Input.is_action_pressed("block")):
		if (block_all):
			action_direction = Enums.ActionDirection.ALL

		if (current_block_direction != action_direction):
				block(action_direction)

	if (Input.is_action_just_released("block")):
		unblock(action_direction)

	move_and_slide()

func attack(action_direction: Enums.ActionDirection):
	print("Player attacking direction: " +
		Enums.ActionDirection.keys()[action_direction])
	match action_direction:
		Enums.ActionDirection.UP:
			animation_player.play("sword_attack_up")
		Enums.ActionDirection.MIDDLE:
			animation_player.play("sword_attack_middle")
		Enums.ActionDirection.DOWN:
			animation_player.play("sword_attack_down")

func block(action_direction: Enums.ActionDirection):
	print("Player blocking direction: " +
		Enums.ActionDirection.keys()[action_direction])

	if (is_blocking):
		if (action_direction == current_block_direction):
			# we are already blocking here, no need to do anything
			return
		else:
			match action_direction:
				# these play() functions basically plays from the end with
				# animation speed of 0
				Enums.ActionDirection.UP:
					animation_player.play("shield_block_up", -1, 0.0, true)
				Enums.ActionDirection.MIDDLE:
					animation_player.play("shield_block_middle", -1, 0.0, true)
				Enums.ActionDirection.DOWN:
					animation_player.play("shield_block_down", -1, 0.0, true)
				Enums.ActionDirection.ALL:
					animation_player.play("shield_block_middle", -1, 0.0, true)
	else:
		# we have not blocked yet
		match action_direction:
			Enums.ActionDirection.UP:
				animation_player.play("shield_block_up", -1, 2.0)
			Enums.ActionDirection.MIDDLE:
				animation_player.play("shield_block_middle", -1, 2.0)
			Enums.ActionDirection.DOWN:
				animation_player.play("shield_block_down", -1, 2.0)
			Enums.ActionDirection.ALL:
				animation_player.play("shield_block_middle", -1, 2.0)

	is_blocking = true
	current_block_direction = action_direction
	_update_block_array(action_direction)

func unblock(action_direction: Enums.ActionDirection):
	print("Player stopped blocking direction: " +
		Enums.ActionDirection.keys()[action_direction])
	is_blocking = false
	current_block_direction = Enums.ActionDirection.NONE
	_update_block_array(Enums.ActionDirection.NONE)

	match action_direction:
		# these play() functions are basically play_backwards(), but 4x as fast
		Enums.ActionDirection.UP:
			animation_player.play("shield_block_up", -1, -4.0, true)
		Enums.ActionDirection.MIDDLE:
			animation_player.play("shield_block_middle", -1, -4.0, true)
		Enums.ActionDirection.DOWN:
			animation_player.play("shield_block_down", -1, -4.0, true)
		Enums.ActionDirection.ALL:
			animation_player.play("shield_block_middle", -1, -4.0, true)

func attacked(enemy: Enemy, damage: int,
		action_direction: Enums.ActionDirection):
	print("Player being attacked! damage %s, direction: %s" %
		[str(damage), Enums.ActionDirection.keys()[action_direction]])
	if (blocking[int(action_direction) - 1]):
		print("Player blocked the attack! Retaliating with %d" % \
			current_block_damage)
		enemy.current_health -= current_block_damage
	else:
		player_attacked_sfx_player.play()
		print("Player got hit!")
		current_health -= damage
		print("Current player health: " + str(current_health))

func _check_death() -> void:
	if (current_health <= 0):
		print("Player died!")
		Globals.Player = null
		queue_free()
		Globals.PlayerDied.emit()

func _update_block_array(block_direction: Enums.ActionDirection):
	var updated_blocking_array := [false, false, false]
	if (block_direction == Enums.ActionDirection.ALL):
		updated_blocking_array = [true, true, true]
	elif (block_direction != Enums.ActionDirection.NONE):
		updated_blocking_array[int(block_direction) - 1] = true

	blocking = updated_blocking_array

func _on_sword_area_up_body_entered(enemy: Enemy) -> void:
	enemy.attacked(self, current_attack, Enums.ActionDirection.UP)

func _on_sword_area_middle_body_entered(enemy: Enemy) -> void:
	enemy.attacked(self, current_attack, Enums.ActionDirection.MIDDLE)

func _on_sword_area_down_body_entered(enemy: Enemy) -> void:
	enemy.attacked(self, current_attack, Enums.ActionDirection.DOWN)
