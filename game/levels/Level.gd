extends Node2D
class_name Level

var Web = preload("res://scenes/Webshot.tscn")
onready var player = get_node("Player")

var flies = 0
var webbed_flies = 0

func add_flies():
	flies += 1
	
func add_web_flies():
	webbed_flies += 1
	test_win()

func test_win():
	if flies == webbed_flies:
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


