extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect/VBoxContainer/RestartButton.connect("pressed", self, "reload_level")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible


func reload_level():
	get_tree().reload_current_scene()
