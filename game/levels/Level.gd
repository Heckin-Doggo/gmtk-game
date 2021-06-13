extends Node2D
class_name Level

# preloaded
var Web = preload("res://scenes/Webshot.tscn")
var RestartDialog = preload("res://ui/RestartDialog.tscn")
onready var player = get_node("Player")
onready var NextDialog = get_node("CanvasLayer/NextLevelDialog")

# global win sound
onready var WinSound = get_node("/root/WinSound")

# script variables
var flies = 0
var webbed_flies = 0


func _ready():
	if has_node("Player"):
		get_node("Player").connect("died", self, "show_restart_dialog")



func add_flies():
	flies += 1
	
func add_web_flies():
	webbed_flies += 1
	test_win()

func test_win():
	if flies == webbed_flies:
		WinSound.play()
		NextDialog.visible = true
		print("you win!")

func create_webhook(hooked_object):
	var new_webhook = Web.instance()
	#set webhooks stuff
	new_webhook.points[0] = player.position
	new_webhook.points[1] = hooked_object.position
	new_webhook.set_click_position()
	
	hooked_object.set_connected_hook(new_webhook)
	
	#adds the new webhook to world and the player's array
	add_child(new_webhook)
	player.add_hook(new_webhook)

func delete_hook(index):
	player.delete_hook(index)
	
func show_restart_dialog():
	var new_dialog = RestartDialog.instance()
	if get_node_or_null("CanvasLayer"):
		get_node_or_null("CanvasLayer").add_child(new_dialog)

