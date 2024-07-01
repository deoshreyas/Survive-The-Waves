extends Sprite2D

const SPEED = 75.0 
var velocity = Vector2()

var stunned = false

var hp = 3

var blood_particles = preload("res://Scenes/blood_particles.tscn")

func _process(delta):
	if Global.player!=null and not stunned:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stunned:
		velocity = lerp(velocity, Vector2.ZERO, 0.3)
	global_position += velocity * SPEED * delta 
	if hp<=0:
		if Global.node_creation_parent!=null:
			var blood_particles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
		queue_free()
		Global.score += 1

func _on_hitbox_area_entered(area):
	if area.is_in_group("Bullets") and not stunned:
		modulate = Color.WHITE
		velocity = -velocity * 6
		stunned = true 
		$StunTimer.start()
		area.get_parent().queue_free()
		hp -= 1 

func _on_stun_timer_timeout():
	modulate = Color("0028ff")
	stunned = false
