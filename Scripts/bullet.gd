extends Sprite2D

const SPEED = 250.0
var velocity = Vector2(1, 0)

var look_once = true 

var damage = 1

func _process(delta):
	if look_once:
		look_at(get_global_mouse_position())
		look_once = false  
	global_position += velocity.rotated(rotation) * SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
