extends RigidBody2D


# Exported script vars
export var bounds = 5  # range in pixels from original_pos where fly will no longer move.
export var speed = 20  # max speed at which fly will return home.

# internal variables
var original_pos = position
var cursor_enabled = true
var connected_hook
var trapped = false

var additional_vector = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	$RandomMovementTimer.connect("timeout", self, "random_movement")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("input_event",  self, "_on_fly_input_event")
	set_bounce(0.2)
	get_parent().add_flies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# animation handler/state checker
	if connected_hook:
		$AnimatedSprite.animation = "trapped"
		cursor_enabled = false
	else:
		if not trapped:
			$AnimatedSprite.animation = "default"
		cursor_enabled = true


func _physics_process(delta):
	var base_vector = Vector2(0,-weight*10)  # keeps the fly in the air.
	var move_vector = Vector2.ZERO
	
	var damp = get_linear_velocity() * -0.4  # reduction in speed
	
	if abs(position.x - original_pos.x) > bounds and abs(position.y - original_pos.y) > bounds and not trapped:
		move_vector += Vector2(position.x-original_pos.x, position.y-original_pos.y)*-1
	
	if connected_hook:
		move_vector += connected_hook.points[0] - position
		
	# speed limit
	move_vector = Vector2(clamp(move_vector.x,-speed, speed), clamp(move_vector.y,-speed,speed))  # speed limit for flies
	
	set_applied_force(base_vector + damp + additional_vector + move_vector)
	
	# clear additional vector
	additional_vector = Vector2.ZERO
	
	if connected_hook:
		connected_hook.points[1] = position
	
	if Input.get_action_strength("ui_accept") > 0 and connected_hook:
		get_parent().delete_hook(connected_hook.get_index())
		connected_hook = null
	
	
func random_movement():
	if not trapped:
		var rand_force = Vector2((randf()-.5)*1000, (randf()-.5)*1000)
		additional_vector = rand_force
		print("set random fly force to:", rand_force)
	
func _on_mouse_entered():
	# $AnimatedSprite.self_modulate = Color(1,1,0)
	if cursor_enabled:
		$Cursor.visible = true
	

func _on_mouse_exited():
	# $AnimatedSprite.self_modulate = Color(1,1,1)
	$Cursor.visible = false # no matter if its enabled or not

func set_connected_hook(new_webhook):
	connected_hook = new_webhook

func _on_fly_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and not connected_hook:
		get_parent().create_webhook(self)
		$Cursor.visible = false
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and connected_hook:
		get_parent().delete_hook(connected_hook.get_index())
		connected_hook = null
		$Cursor.visible = true

func trap():
	$AnimatedSprite.animation = "trapped"
	trapped = true
	get_parent().add_web_flies()

func untrap():
	$AnimatedSprite.animation = "default"
	trapped = false
