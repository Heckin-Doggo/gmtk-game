extends Line2D

var selectable = false
var index

func _ready():
	visible = true

func set_click_position():
	$Area2D/CollisionShape2D.position = points[1]

func set_index(index_num):
	index = index_num

func _on_Area2D_mouse_entered():
	default_color = Color(0.55, 0, 0, 1)
	selectable = true

func _on_Area2D_mouse_exited():
	default_color = Color(1, 1, 1, 1)
	selectable = false

func update_position(new_position):
	points[0] = new_position
	set_click_position()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and selectable:
			get_parent().get_child(0).delete_hook(index)
