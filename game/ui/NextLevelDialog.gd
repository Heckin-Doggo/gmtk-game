extends Control


export var next_level_path = "res://levels/BasicLevel.tscn"

func _ready():
	$NinePatchRect/VBoxContainer/NextButton.connect("pressed", self, "go_to_next")


func go_to_next():
	get_tree().change_scene(next_level_path)
