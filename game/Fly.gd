extends RigidBody2D


# Declare member variables here. Examples:
var original_pos = position
export var dampening = 10
export var bounds = 5

var additional_vector = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	$RandomMovementTimer.connect("timeout", self, "random_movement")


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
	
func random_movement():
	var rand_force = Vector2((randf()-.5)*1000, (randf()-.5)*1000)
	additional_vector = rand_force
	print("set random fly force to:", rand_force)
