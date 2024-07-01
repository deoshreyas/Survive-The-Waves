extends Node2D

var fade = false 
var alpha = 1

func _process(_delta):
	if fade:
		alpha -= 0.005
		modulate.a = alpha 
		if alpha < 0.005:
			queue_free()

func _on_fadeout_timer_timeout():
	fade = true 
