extends Area2D

func _on_leave_game_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_tree().quit()
