extends Control

var player_health_progress_bar: TextureProgressBar = null
var enemy_health_progress_bar: TextureProgressBar = null

var start_display: bool = false
var combat_finished: bool = false

func _ready() -> void:
	Globals.connect("EnemyDied", _on_enemy_died)
	Globals.connect("PlayerDied", _on_player_died)
	Globals.connect("CombatStarted", _on_combat_started)
	player_health_progress_bar = get_node("PlayerHealthProgressBar")
	enemy_health_progress_bar = get_node("EnemyHealthProgressBar")
	player_health_progress_bar.hide()
	enemy_health_progress_bar.hide()

func _on_combat_started() -> void:
	player_health_progress_bar.max_value = Globals.Player.stat_health
	player_health_progress_bar.value = Globals.Player.current_health
	player_health_progress_bar.show()
	
	enemy_health_progress_bar.max_value = Globals.Enemy.stat_health
	enemy_health_progress_bar.value = Globals.Enemy.current_health
	enemy_health_progress_bar.show()
	
	start_display = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (start_display and not combat_finished):
		player_health_progress_bar.value = Globals.Player.current_health
		enemy_health_progress_bar.value = Globals.Enemy.current_health

func _on_enemy_died() -> void:
	combat_finished = true
	enemy_health_progress_bar.value = 0

func _on_player_died() -> void:
	combat_finished = true
	player_health_progress_bar.value = 0
