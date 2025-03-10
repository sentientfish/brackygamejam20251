extends Node

signal CombatStarted
signal EnemyDied
signal PlayerDied

var Muted := false
var ParrotObtained := false

var Player: Player = null
var Enemy: Enemy = null

var Victories := 0

var PlayerStatusEffects := []
var EnemyStatusEffects := []

var VendorItems := [
	HerculeanStrength.new(),
	Excalibur.new(),
	Quickfeet.new(),
	TrollsHeart.new(),
	FoodPoisoning.new(),
	BigBadShield.new(),
	ShoulderParrot.new(),
]
