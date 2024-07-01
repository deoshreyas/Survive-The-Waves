extends Sprite2D

const SPEED = 150.0
var velocity = Vector2()

var bullet = preload("res://Scenes/bullet.tscn")

var can_shoot = true 

func _ready():
	Global.player = self 

func _process(delta):
	velocity = Input.get_vector("btn_left", "btn_right", "btn_up", "btn_down").normalized()
	global_position += velocity * SPEED * delta
	if Input.is_action_pressed("shoot") and Global.node_creation_parent!=null and can_shoot:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Timer.start()
		can_shoot = false

func _on_timer_timeout():
	can_shoot = true
	
func _exit_tree():
	Global.player = null
