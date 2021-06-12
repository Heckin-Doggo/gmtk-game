extends RigidBody2D
class_name Player

var Web = preload("res://scenes/Webshot.tscn")
#the directions of the strings
var webhooks = []

#sounds
onready var soundRetract = get_node("Retract")
onready var soundShoot = get_node("Shoot")
onready var soundArgh = get_node("argh")

func _ready():
	set_bounce(0.2)

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
	
	#applies dampening if there are hooks
	var damp = Vector2.ZERO
	if webhooks:
		damp = get_linear_velocity() * -0.9
	
	set_applied_force((velocity + damp) * 2)
	if get_linear_velocity().x < 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
	if not $RayCast2D.is_colliding():
		$Sprite.animation = "Fly"
	else:
		$Sprite.animation = "Default"

func delete_hook(index):
	#removes the webhook from the array
	var dead_hook = webhooks[index]
	webhooks.remove(index)
	
	#updates array index for the rest of the hooks
	var hook_index = 0
	for hook in webhooks:
		if hook_index >= index:
			hook.set_index(hook_index)
		hook_index += 1
	
	soundRetract.play()
	dead_hook.queue_free()

func add_hook(new_webhook):
	new_webhook.set_index(webhooks.size())
	webhooks.append(new_webhook)
	soundShoot.play()

func die():
	soundArgh.play()
	print("you died!")
