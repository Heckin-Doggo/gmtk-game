extends Area2D

var center = Vector2.ZERO

func _on_SpiderWeb_body_entered(body):
	if body.has_method("trap"):
		body.trap(position)
