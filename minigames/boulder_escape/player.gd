extends CharacterBody2D

var input_dir: float = 0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	move_and_slide()
	input_dir = Input.get_axis("left", "right")
	velocity.x = input_dir * 200
	if is_on_floor():
		if input_dir != 0:
			sprite.play("walk")
		else:
			sprite.play("idle")
		if Input.is_action_just_pressed("up"):
			velocity.y = -1000
			sprite.play("jump")
	else:
		if velocity.y < 0:
			velocity.y += 30
		else:
			sprite.play("fall")
			velocity.y += 20
	if velocity.x > 0:
		sprite.flip_h = false
	if velocity.x < 0:
		sprite.flip_h = true
