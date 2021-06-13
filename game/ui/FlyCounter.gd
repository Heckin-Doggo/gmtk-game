extends Control


onready var Globals = get_node("/root/Globals")

func _process(delta):
	$Label.text = "x " + str(Globals.flies_left)
