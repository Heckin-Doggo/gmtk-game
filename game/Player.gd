extends RigidBody2D

var Web = preload("res://scenes/Webshot.tscn")

var velocity = Vector2.ZERO
#the directions of the strings
var webhooks = []


func _physics_process(delta):
	velocity = Vector2.ZERO
	
	#loops over each webhook
	for webhook in webhooks:
		#Gets the end of the strings position and the vector to that position
		var hook_point = webhook.points[1]
		velocity += webhook.position
	
	print(velocity)
	set_linear_velocity(velocity)


func new_hook(pos):
	var new_hook = Web.instance()
	new_hook.points[1] = Vector2(pos.x - position.x, pos.y - position.y)
	add_child(new_hook)
	webhooks.append(new_hook)
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			new_hook(event.position)
