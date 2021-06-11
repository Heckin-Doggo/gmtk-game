extends RigidBody2D

var Web = preload("res://scenes/Webshot.tscn")
#the directions of the strings
var webhooks = []

export var DAMP = 0.9

func _physics_process(delta):
	var velocity = Vector2.ZERO
	#loops over each webhook
	for webhook in webhooks:
		webhook.points[0] = position
		#Gets the end of the strings position and the vector to that position
		var hook_point = webhook.points[1]
		var pull = hook_point - position
		#adds that vector to the velocity
		velocity = velocity + pull * 3
	
	set_applied_force(velocity)

#Adds a line2d webhook and adds it to the array of current webhooks
func shoot_web(hook_position):
	var new_webhook = Web.instance()
	
	new_webhook.set_index(webhooks.size())
	new_webhook.points[0] = position
	new_webhook.points[1] = hook_position
	new_webhook.set_click_position()
	
	get_parent().add_child(new_webhook)
	webhooks.append(new_webhook)

func delete_hook(index):
	var dead_hook = webhooks[index]
	webhooks.remove(index)
	
	var hook_index = 0
	for hook in webhooks:
		if hook_index >= index:
			hook.set_index(hook_index)
		hook_index += 1
	
	dead_hook.queue_free()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:  # make sure its actually pressed. prevent double click
				shoot_web(event.position)
