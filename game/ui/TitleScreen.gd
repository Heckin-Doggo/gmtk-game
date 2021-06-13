extends Node2D

var LevelSelect = preload("res://ui/LevelSelect.tscn")
var CreditsDialog = preload("res://ui/CreditsDialog.tscn")

func _ready():
	# connections
	$StartButton.connect("pressed", self, "start_game")
	$LevelButton.connect("pressed", self, "level_select")
	$CreditsButton.connect("pressed", self, "show_credits")
	

func start_game():
	print("GAME STARTING")
	get_tree().change_scene("res://levels/Tutorial.tscn")

func level_select():
	if get_parent().has_node("LevelSelect") == false:
		var new_dialog = LevelSelect.instance()
		get_parent().add_child(new_dialog)
		
func show_credits():
	if get_parent().has_node("CreditsDialog") == false:
		var new_dialog = CreditsDialog.instance()
		get_parent().add_child(new_dialog)
