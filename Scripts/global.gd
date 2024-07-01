extends Node

var node_creation_parent = null 
var player = null

var score = 0
var hi_score = 0

var camera = null

func instance_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location 
	return node_instance 
	
func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(hi_score)

func load_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file!=null:
		hi_score = save_file.get_32()
	else:
		hi_score = 0
		save_game() 
