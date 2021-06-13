extends Control


func _ready():
	$NinePatchRect/VBoxContainer/HBoxContainer/ReturnButton.connect("pressed", self, "return_to_menu")

func return_to_menu():
	queue_free()
