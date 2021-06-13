extends Control




func _ready():
#	for button in $NinePatchRect/VBoxContainer/LevelButtons.get_children():
#		button.connect("pressed", self, "select_level")
	for i in range(1,7):
		var x = str(i)
		get_node("NinePatchRect/VBoxContainer/LevelButtons/Level"+x).connect("pressed", self, "select_"+x)
	$NinePatchRect/VBoxContainer/TutorialButton.connect("pressed", self, "select_tutorial")
	$NinePatchRect/VBoxContainer/ReturnButtonContainer/ReturnButton.connect("pressed", self, "go_back")

# level selects
func select_1():
	get_tree().change_scene("res://levels/Level1.tscn")

func select_2():
	get_tree().change_scene("res://levels/Level2.tscn")
	
func select_3():
	get_tree().change_scene("res://levels/Level3.tscn")
	
func select_4():
	get_tree().change_scene("res://levels/Level4.tscn")
	
func select_5():
	get_tree().change_scene("res://levels/Level5.tscn")

func select_6():
	get_tree().change_scene("res://levels/Level6.tscn")

func select_tutorial():
	get_tree().change_scene("res://levels/Tutorial.tscn")
	
func go_back():
	queue_free()
