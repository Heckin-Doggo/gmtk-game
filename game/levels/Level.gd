extends Node2D

var Web = preload("res://scenes/Webshot.tscn")
onready var player = get_node("Player")

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
