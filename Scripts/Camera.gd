extends Camera2D

var screen_shake_start = false 
var shake_intensity = 0 

func _ready():
	Global.camera = self 
	
func _exit_tree():
	Global.camera = null

func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), 0.3)
	if screen_shake_start:
		global_position += Vector2(randi_range(-shake_intensity, shake_intensity), randi_range(-shake_intensity, shake_intensity)) * delta 
	else:
		global_position = lerp(global_position, Vector2(320, 180), 0.3)
	
func screen_shake(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity*0.0015, intensity*0.0015)
	shake_intensity = intensity
	$ScreenShakeTimer.wait_time = time
	$ScreenShakeTimer.start()
	screen_shake_start = true

func _on_screen_shake_timer_timeout():
	screen_shake_start = false 
