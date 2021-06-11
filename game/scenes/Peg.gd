extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal peg_clicked


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event",  self, "_on_Peg_input_event")


func _on_Peg_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print("it work")
		if $AnimatedSprite.animation == "off":
			$AnimatedSprite.animation = "on"
			emit_signal("peg_clicked", Vector2(position.x, position.y))
		else:
			$AnimatedSprite.animation = "off"
