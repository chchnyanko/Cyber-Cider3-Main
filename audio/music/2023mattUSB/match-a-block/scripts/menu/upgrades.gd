extends Area2D

func _on_upgrades_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_tree().change_scene("res://scenes/gameplay/shop.tscn")
