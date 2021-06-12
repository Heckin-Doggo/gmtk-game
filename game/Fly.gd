extends RigidBody2D


# Declare member variables here. Examples:
var original_pos = position
export var dampening = 10
export var bounds = 5

var connected_hook

var additional_vector = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	$RandomMovementTimer.connect("timeout", self, "random_movement")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("input_event",  self, "_on_fly_input_event")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var base_vector = Vector2(0,-weight*10)  # keeps the fly in the air.
	
	var damp = get_linear_velocity() * -0.4  # reduction in speed
	
	if abs(position.x - original_pos.x) > bounds and abs(position.y - original_pos.y) > bounds:
		base_vector += Vector2(position.x-original_pos.x, position.y-original_pos.y)*-1
	set_applied_force(base_vector + damp + additional_vector)
	
	# clear additional vector
	additional_vector = Vector2.ZERO
	
	if connected_hook:
		connected_hook.points[1] = position
	
	if Input.get_action_strength("ui_accept") > 0 and connected_hook:
		get_parent().delete_hook(connected_hook.get_index())
		connected_hook = null
	
	
func random_movement():
	var rand_force = Vector2((randf()-.5)*1000, (randf()-.5)*1000)
	additional_vector = rand_force
	print("set random fly force to:", rand_force)
	
func _on_mouse_entered():
	$AnimatedSprite.self_modulate = Color(1,1,0)

func _on_mouse_exited():
	$AnimatedSprite.self_modulate = Color(1,1,1)

func set_connected_hook(new_webhook):
	connected_hook = new_webhook

func _on_fly_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and not connected_hook:
			get_parent().create_webhook(self)
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and connected_hook:
		get_parent().delete_hook(connected_hook.get_index())
		connected_hook = null
	
	# animation handler
	if connected_hook:
		$AnimatedSprite.animation = "trapped"
	else:
		$AnimatedSprite.animation = "default"
