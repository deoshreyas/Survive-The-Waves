extends Label

func _ready():
	text = "0"

func _process(_delta):
	text = str(Global.score)
