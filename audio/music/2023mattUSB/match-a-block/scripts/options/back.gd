extends Area2D

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_tree().change_scene("res://scenes/menu/main_menu.tscn")
