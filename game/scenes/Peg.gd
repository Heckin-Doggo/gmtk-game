extends StaticBody2D

var connected_hook
signal peg_clicked


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event",  self, "_on_Peg_input_event")

func set_connected_hook(webhook):
	connected_hook = webhook

func _on_Peg_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and not connected_hook:
		if $AnimatedSprite.animation == "off":
			$AnimatedSprite.animation = "on"
			emit_signal("peg_clicked", Vector2(position.x, position.y))
			get_parent().create_webhook(self)
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and connected_hook:
		get_parent().delete_hook(connected_hook.get_index())
		connected_hook = null
		$AnimatedSprite.animation = "off"

