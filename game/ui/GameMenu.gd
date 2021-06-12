extends Control

# other dialogs
var LevelSelect = preload("res://ui/LevelSelect.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect/VBoxContainer/RestartButton.connect("pressed", self, "reload_level")
	$NinePatchRect/VBoxContainer/LevelSelectButton.connect("pressed", self, "level_select")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible


func reload_level():
	get_tree().reload_current_scene()

func level_select():
	if get_parent().has_node("LevelSelect") == false:
		var new_dialog = LevelSelect.instance()
		get_parent().add_child(new_dialog)

