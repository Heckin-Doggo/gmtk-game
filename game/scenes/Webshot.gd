extends Line2D

var selectable = false
#place of this hook in the players array of hooks
var index

#sets clickable position to attach point
func set_click_position():
	$Area2D/CollisionShape2D.position = points[1]

#sets the index, see above
func set_index(index_num):
	index = index_num

func get_index():
	return index

#highlights the hook
func _on_Area2D_mouse_entered():
	default_color = Color(0.55, 0, 0, 1)
	selectable = true
	
#unhighlights the hook
func _on_Area2D_mouse_exited():
	default_color = Color(1, 1, 1, 1)
	selectable = false
	
#will update the attach point of a hook
func update_position(new_position):
	points[0] = new_position
	set_click_position()

#func _unhandled_input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_RIGHT and selectable:
#			get_parent().delete_hook(index)
