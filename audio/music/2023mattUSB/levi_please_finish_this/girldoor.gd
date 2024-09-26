extends Area2D

var entered = false

func _ready():
	entered = false

func _on_door_body_entered(body):
	if body.name == "girl":
		entered = true

func _on_door_body_exited(body):
	if body.name == "girl":
		entered = false

func _process(delta):
	if entered:
		if Input.is_action_just_pressed("jump2"):
			settings.girldoor = !settings.girldoor
			sound.door()
			if $Door.frame == 0:
				$Door.frame = 1
			else:
				$Door.frame = 0
