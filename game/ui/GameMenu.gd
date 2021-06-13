extends Control

# other dialogs
var LevelSelect = preload("res://ui/LevelSelect.tscn")
var ControlsDialog = preload("res://ui/ControlsDialog.tscn")

# volumes
var volumes = [-80, -30, -15, 0]
onready var globals = get_node("/root/Globals")
onready var Music = get_node("/root/BGM")

# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect/VBoxContainer/RestartButton.connect("pressed", self, "reload_level")
	$NinePatchRect/VBoxContainer/LevelSelectButton.connect("pressed", self, "level_select")
	$NinePatchRect/VBoxContainer/ControlsButton.connect("pressed", self, "show_controls")
	$NinePatchRect/VBoxContainer/MainMenuButton.connect("pressed", self, "return_to_menu")
	$VolumeIcon/VolButton.connect("pressed", self, "toggle_volume")
	

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		update_volume_icon()


func reload_level():
	get_tree().reload_current_scene()

func level_select():
	if get_parent().has_node("LevelSelect") == false:
		var new_dialog = LevelSelect.instance()
		get_parent().add_child(new_dialog)


func show_controls():
	if get_parent().has_node("ControlsDialog") == false:
		var new_dialog = ControlsDialog.instance()
		get_parent().add_child(new_dialog)
		

func return_to_menu():
	get_tree().change_scene("res://ui/TitleScreen.tscn")
	


func update_volume_icon():
	var current_vol = globals.volume_BGM
	for item in $VolumeIcon.get_children():
		if item is TextureRect:
			item.visible = false
	get_node("VolumeIcon/Volume"+str(current_vol)).visible = true  # show current


func toggle_volume():
	var current_vol = globals.volume_BGM
	var new_vol = current_vol + 1
	if new_vol == 4:
		new_vol = 0  # loops it back
		Music.stream_paused = true
	else:
		Music.stream_paused = false
		Music.volume_db = volumes[new_vol]
	globals.volume_BGM = new_vol
	update_volume_icon()
		
	
	

