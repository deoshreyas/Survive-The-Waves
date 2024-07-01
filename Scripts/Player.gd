extends Sprite2D

const SPEED = 150.0
var velocity = Vector2()

var bullet = preload("res://Scenes/bullet.tscn")

var reload_speed = 0.1
var default_reload_speed = 0.1

var power_up_reset = []

var can_shoot = true 

var is_dead = false

var damage = 1
var default_damage = damage

func _ready():
	Global.player = self 

func _process(delta):
	velocity = Input.get_vector("btn_left", "btn_right", "btn_up", "btn_down").normalized()
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if not is_dead:
		global_position += velocity * SPEED * delta
		if Input.is_action_pressed("shoot") and Global.node_creation_parent!=null and can_shoot:
			var bullet_instance = Global.instance_node(bullet, global_position, Global.node_creation_parent)
			bullet_instance.damage = damage
			$Timer.start()
			can_shoot = false

func _on_timer_timeout():
	can_shoot = true
	$Timer.wait_time = reload_speed
	
func _exit_tree():
	Global.player = null

func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		visible = false 
		is_dead = true
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()

func _on_powerup_timer_timeout():
	if power_up_reset.find("Powerup_reload")!=null:
		reload_speed = default_reload_speed
		power_up_reset.erase("Powerup_reload")
	elif power_up_reset.find("Powerup_damage")!=null:
		damage = default_damage
		power_up_reset.erase("Powerup_damage")
