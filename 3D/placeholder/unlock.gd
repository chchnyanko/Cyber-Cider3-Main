extends Area3D

@export var move: String

func _on_body_entered(body: Node3D) -> void:
	if body is yarts:
		body.change_state(body.statemachine.cut_scene, str("unlock", move))
		queue_free()
