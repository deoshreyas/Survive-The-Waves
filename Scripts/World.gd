extends Node2D

var enemy = preload("res://Scenes/enemy.tscn")

func _ready():
	Global.node_creation_parent = self 

func _exit_tree():
	Global.node_creation_parent = null

func _on_enemy_spawn_timer_timeout():
	var enemy_pos = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	while enemy_pos.x<640 and enemy_pos.x>-80 or enemy_pos.y<360 and enemy_pos.y>-45:
		enemy_pos = Vector2(randi_range(-160, 670), randi_range(-90, 390)) 
	Global.instance_node(enemy, enemy_pos, self)
