extends Area3D

@export var game: String

var index: Vector2i

func _ready() -> void:
	var num: float = float(name.replace("cube_piece", ""))
	index.x = int(ceil(num / 6))
	index.y = int(num) % 6
	if index.y == 0:
		index.y = 6
	if unlocks.get(str("cube_", index.x, "_", index.y)):
		queue_free()

func _process(delta: float) -> void:
	rotate_y(0.01)

func _on_body_entered(body: Node3D) -> void:
	if body is yarts:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		data.checkpoint_name = game
		data.checkpoint_pos = body.position - Vector3(1.5, 0, 0)
		var scene = str("res://minigames/", game, "/", game, ".tscn")
		get_tree().change_scene_to_file(scene)
