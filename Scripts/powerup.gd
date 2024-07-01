extends Sprite2D

@export var player_variable_modify : String
@export var player_variable_set : float

@export var powerup_cooldown = 2

func _on_hitbox_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().set(player_variable_modify, player_variable_set)
		area.get_parent().get_node("PowerupTimer").wait_time = 2
		area.get_parent().get_node("PowerupTimer").start()
		area.get_parent().power_up_reset.append(name)
		queue_free()
