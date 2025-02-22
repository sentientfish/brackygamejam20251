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

func _ready() -> void:
	Globals.Enemy = self
	
	# Triggers all effects on enemy
	for effect in Globals.EnemyStatusEffects:
		effect.trigger_effect(self)

func _physics_process(delta: float) -> void:
	pass

func attack(action_direction: Enums.ActionDirection):
	pass

func block(action_direction: Enums.ActionDirection):
	pass

func unblock(action_direction: Enums.ActionDirection):
	pass

func attacked(player: Player, damage: int, action_direction: Enums.ActionDirection):
	pass
