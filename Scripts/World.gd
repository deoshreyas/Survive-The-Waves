extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
@export var powerups: Array[PackedScene] = []

func _ready():
	Global.node_creation_parent = self 
	Global.score = 0

func _exit_tree():
	Global.node_creation_parent = null

func _on_enemy_spawn_timer_timeout():
	var enemy_pos = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	while enemy_pos.x<640 and enemy_pos.x>-80 and enemy_pos.y<360 and enemy_pos.y>-45:
		enemy_pos = Vector2(randi_range(-160, 670), randi_range(-90, 390)) 
	var enemy = enemy_scenes.pick_random()
	Global.instance_node(enemy, enemy_pos, self)

func _on_difficulty_timer_timeout():
	if $EnemySpawnTimer.wait_time > 0.5:
		$EnemySpawnTimer.wait_time -= 0.025

func _on_powerup_spawn_timer_timeout():
	var powerup = powerups.pick_random()
	Global.instance_node(powerup, Vector2(randi_range(0, 640), randi_range(0, 360)), self)
