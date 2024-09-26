extends Area2D

func _on_Area2D3_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_tree().change_scene("res://scenes/options/tutorial.tscn")

func _ready():
	randomize()
	$AnimatedSprite.frame = randi()%7+1
