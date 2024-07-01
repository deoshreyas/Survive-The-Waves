extends Label

func _ready():
	Global.load_game()
	text = str(Global.hi_score)
	
func _process(_delta):
	if Global.score > Global.hi_score:
		Global.hi_score = Global.score
