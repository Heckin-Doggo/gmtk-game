extends KinematicBody2D

var ACCELERATION = 700
var FRICTION = 1500
var MOVE_SPEED = 200
var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MOVE_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide(velocity)
