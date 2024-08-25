extends Node3D

func _ready() -> void:
	if data.tutorial:
		return
	$Yarts.change_state($Yarts.statemachine.cut_scene, "tutorial")
	data.tutorial = true


func _on_top_of_tower_body_entered(body: Node3D) -> void:
	if body is yarts:
		body.change_state(body.statemachine.cut_scene, "end")
