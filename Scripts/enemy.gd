extends Sprite2D

const SPEED = 75.0 
var velocity = Vector2()

func _process(delta):
	if Global.player!=null:
		velocity = global_position.direction_to(Global.player.global_position)
	global_position += velocity * SPEED * delta 

func _on_hitbox_area_entered(area):
	if area.is_in_group("Bullets"):
		$StunTimer.start()
		modulate = Color.WHITE
		area.get_parent().queue_free()

func _on_stun_timer_timeout():
	modulate = Color("0028ff")
