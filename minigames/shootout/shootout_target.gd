extends Area2D

signal hit

func initiate():
	position = Vector2(randi_range(0, 1920), randi_range(0, 1080))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed == true:
			hit.emit()
