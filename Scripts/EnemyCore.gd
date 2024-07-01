extends Sprite2D

@export var speed = 75
var velocity = Vector2()

var stunned = false

@export var hp = 3

@export var knockback = 600

@onready var current_colour = modulate 

@export var screen_shake = 120

var blood_particles = preload("res://Scenes/blood_particles.tscn")

func _process(_delta):
	if hp<=0:
		print(1)
		if Global.camera!=null:
			Global.camera.screen_shake(screen_shake, 0.2)
		if Global.node_creation_parent!=null:
			var blood_particles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
			blood_particles_instance.modulate = Color.from_hsv(current_colour.h, 0.75, current_colour.v)
		queue_free()
		Global.score += 1

func basic_movement(delta):
	if Global.player!=null and not stunned:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speed * delta 
	elif stunned:
		velocity = lerp(velocity, Vector2.ZERO, 0.3)
		global_position += velocity * delta 
	
func _on_hitbox_area_entered(area):
	if area.is_in_group("Bullets") and not stunned:
		modulate = Color.WHITE
		velocity = -velocity * knockback
		stunned = true 
		$StunTimer.start()
		area.get_parent().queue_free()
		hp -= area.get_parent().damage
		
func _on_stun_timer_timeout():
	modulate = current_colour
	stunned = false
