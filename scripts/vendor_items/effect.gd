class_name Effect extends Node

var effect_name: String = ""
var icon: Texture = null
var max_stacks: int = 0
var owned_stacks: int = 0
var available: bool = true
var target_player: bool = true

func trigger_effect(character: CharacterBody2D) -> void:
	pass

func remove_from_store() -> void:
	var self_index := 0
	for item in Globals.VendorItems:
		if (item != self):
			self_index += 1
		else:
			break

	Globals.VendorItems.remove_at(self_index)
	available = false

func append_effect() -> void:
	var target_status_effect_list := []
	if (target_player):
		target_status_effect_list = Globals.PlayerStatusEffects
	else:
		target_status_effect_list = Globals.EnemyStatusEffects

	if (self in target_status_effect_list and owned_stacks < max_stacks):
		owned_stacks += 1
	else:
		target_status_effect_list.append(self)
		owned_stacks += 1

	if (owned_stacks == max_stacks):
		remove_from_store()

func _init():
	pass
