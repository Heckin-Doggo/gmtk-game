extends StaticBody2D

var connected_hook
signal peg_clicked
var cursor_enabled = true


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("input_event",  self, "_on_Peg_input_event")

func _process(delta):
	if Input.get_action_strength("ui_accept") > 0 and connected_hook:
		get_parent().delete_hook(connected_hook.get_index())
		connected_hook = null
		$AnimatedSprite.animation = "off"
		cursor_enabled = true

func set_connected_hook(webhook):
	connected_hook = webhook

# Cursor handling
func _on_mouse_entered():
	if cursor_enabled:
		$Cursor.visible = true

func _on_mouse_exited():
	$Cursor.visible = false # no matter if its enabled or not


func _on_Peg_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and not connected_hook:
		$AnimatedSprite.animation = "on"
		cursor_enabled = false
		$Cursor.visible = false
		emit_signal("peg_clicked", Vector2(position.x, position.y))
		get_parent().create_webhook(self)
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and connected_hook:
		get_parent().delete_hook(connected_hook.get_index())
		connected_hook = null
		$AnimatedSprite.animation = "off"
		cursor_enabled = true
		$Cursor.visible = true

