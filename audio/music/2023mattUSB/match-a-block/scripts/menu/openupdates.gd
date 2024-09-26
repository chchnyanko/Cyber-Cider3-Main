extends Area2D



func _on_updates_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_tree().change_scene("res://scenes/else/update log.tscn")
