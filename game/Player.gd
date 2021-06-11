extends RigidBody2D

var Web = preload("res://scenes/Webshot.tscn")

var velocity = Vector2.ZERO
#the directions of the strings
var webhooks = []

func _physics_process(delta):
	#loops over each webhook
	for webhook in webhooks:
		#Gets the end of the strings position and the vector to that position
		var hook_point = webhook.points[1]
		var pull = hook_point - position
		#adds that vector to the velocity
		velocity = velocity + pull
	
	set_linear_velocity(velocity)

#Adds a line2d webhook and adds it to the array of current webhooks
func shoot_web(hook_position):
	var new_webhook = Web.instance()
	new_webhook.points[1] = hook_position
	add_child(new_webhook)
	webhooks.append(new_webhook)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			shoot_web(event.position)