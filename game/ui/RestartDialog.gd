extends Control


onready var Music = ("/root/BGM")


# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect/VBoxContainer/RestartButton.connect("pressed", self, "restart_level")

func restart_level():
	Music.play()  # restart after sad death
	get_tree().reload_current_scene()
