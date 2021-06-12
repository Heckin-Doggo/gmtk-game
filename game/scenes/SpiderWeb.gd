extends Area2D

func _on_SpiderWeb_body_entered(body):
	if body.has_method("trap"):
		body.trap()

func _on_SpiderWeb_body_exited(body):
	if body.has_method("untrap"):
		body.untrap()
