extends Node3D

@export var title: String ## This will be the name displayed on the save file

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is yarts:
		data.checkpoint_name = title
		data.checkpoint_pos = position
		data.save_game()
