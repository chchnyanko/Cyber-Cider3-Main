extends Area2D

signal hit
signal die

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func initiate(phase: int):
	phase = phase % 3
	sprite.play(str("level", phase))
	position = Vector2(randi_range(0, 1920), randi_range(0, 1080))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed == true:
			hit.emit()
			sprite.play("death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "death":
		die.emit()
		queue_free()
